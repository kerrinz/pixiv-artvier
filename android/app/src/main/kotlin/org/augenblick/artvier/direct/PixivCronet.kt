package org.augenblick.artvier.direct

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.chromium.net.CronetEngine
import org.chromium.net.CronetException
import org.chromium.net.ExperimentalCronetEngine
import org.chromium.net.UploadDataProviders
import org.chromium.net.UrlRequest
import org.chromium.net.UrlResponseInfo
import org.json.JSONObject
import java.io.ByteArrayOutputStream
import java.net.SocketTimeoutException
import java.nio.ByteBuffer
import java.util.Locale
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicReference

/**
 * Pixiv API / OAuth / Pixivision 直连：Cronet QUIC（HTTP/3）。
 *
 * TCP+TLS 握手里只要出现 *.pixiv.net SNI 就会被 RST。Cronet 按 QUIC hint
 * 直接走 UDP，并用 HostResolverRules 把域名钉到 Cloudflare IP，绕开被污染的 DNS。
 * URL 仍使用域名，Cloudflare 靠 SNI/Host 选站。
 */
object PixivCronet {
    private const val TAG = "PixivCronet"
    private const val MAX_RESPONSE_BYTES = 32 * 1024 * 1024

    const val CF_IP_PRIMARY = "104.18.42.239"

    private val directHosts = setOf(
        "app-api.pixiv.net",
        "oauth.secure.pixiv.net",
        "www.pixiv.net",
        "www.pixivision.net",
    )

    private val skippedRequestHeaders = setOf(
        "connection",
        "content-length",
        "host",
        "keep-alive",
        "proxy-connection",
        "transfer-encoding",
        "upgrade",
    )

    private val executor = Executors.newFixedThreadPool(4)
    private val mainHandler = Handler(Looper.getMainLooper())
    private val liveRequests = ConcurrentHashMap<String, UrlRequest>()

    @Volatile
    private var engine: CronetEngine? = null

    fun request(context: Context, call: MethodCall, result: MethodChannel.Result) {
        val id = call.argument<String>("id") ?: ""
        val url = call.argument<String>("url") ?: ""
        val method = call.argument<String>("method") ?: "GET"
        val timeoutMillis = (call.argument<Number>("timeoutMillis") ?: 30000).toLong()
        val headers = LinkedHashMap<String, String>()
        val rawHeaders = call.argument<Map<*, *>>("headers")
        rawHeaders?.forEach { (key, value) ->
            if (key != null && value != null) {
                headers[key.toString()] = value.toString()
            }
        }
        val body = call.argument<ByteArray>("body")

        executor.execute {
            try {
                val response = execute(context.applicationContext, id, url, method, headers, body, timeoutMillis)
                mainHandler.post { result.success(response) }
            } catch (e: RequestCancelled) {
                mainHandler.post { result.error("CANCELLED", e.message, null) }
            } catch (e: SocketTimeoutException) {
                mainHandler.post { result.error("TIMEOUT", e.message, null) }
            } catch (e: Exception) {
                Log.e(TAG, "request failed $method $url", e)
                mainHandler.post { result.error("CRONET", e.message ?: e.javaClass.simpleName, null) }
            }
        }
    }

    fun cancel(id: String) {
        liveRequests.remove(id)?.cancel()
    }

    private fun engine(context: Context): CronetEngine {
        engine?.let { return it }
        synchronized(this) {
            engine?.let { return it }
            val cacheDir = java.io.File(context.cacheDir, "cronet").apply { mkdirs() }
            val rules = "MAP app-api.pixiv.net $CF_IP_PRIMARY," +
                " MAP oauth.secure.pixiv.net $CF_IP_PRIMARY," +
                " MAP www.pixiv.net $CF_IP_PRIMARY," +
                " MAP www.pixivision.net $CF_IP_PRIMARY"
            val experimental = JSONObject()
                .put("HostResolverRules", JSONObject().put("host_resolver_rules", rules))
                .toString()
            val built = ExperimentalCronetEngine.Builder(context)
                .enableQuic(true)
                .enableHttp2(true)
                .setStoragePath(cacheDir.absolutePath)
                .addQuicHint("app-api.pixiv.net", 443, 443)
                .addQuicHint("oauth.secure.pixiv.net", 443, 443)
                .addQuicHint("www.pixiv.net", 443, 443)
                .addQuicHint("www.pixivision.net", 443, 443)
                .setExperimentalOptions(experimental)
                .build()
            engine = built
            return built
        }
    }

    private fun execute(
        context: Context,
        id: String,
        url: String,
        method: String,
        headers: Map<String, String>,
        body: ByteArray?,
        timeoutMillis: Long,
    ): Map<String, Any?> {
        val host = android.net.Uri.parse(url).host?.lowercase(Locale.US)
        if (host == null || host !in directHosts) {
            throw IllegalArgumentException("Cronet direct connect does not handle host: $host")
        }

        val latch = CountDownLatch(1)
        val bodyOut = ByteArrayOutputStream()
        val error = AtomicReference<Throwable?>(null)
        val infoRef = AtomicReference<UrlResponseInfo?>(null)
        val cronetEngine = engine(context)
        val startedAt = System.nanoTime()

        val callback = object : UrlRequest.Callback() {
            override fun onRedirectReceived(request: UrlRequest, info: UrlResponseInfo, newLocationUrl: String) {
                request.followRedirect()
            }

            override fun onResponseStarted(request: UrlRequest, info: UrlResponseInfo) {
                infoRef.set(info)
                request.read(ByteBuffer.allocateDirect(32 * 1024))
            }

            override fun onReadCompleted(request: UrlRequest, info: UrlResponseInfo, byteBuffer: ByteBuffer) {
                byteBuffer.flip()
                val remaining = byteBuffer.remaining()
                if (bodyOut.size() + remaining > MAX_RESPONSE_BYTES) {
                    error.compareAndSet(
                        null,
                        IllegalStateException("Response exceeds $MAX_RESPONSE_BYTES bytes"),
                    )
                    request.cancel()
                    return
                }
                val tmp = ByteArray(remaining)
                byteBuffer.get(tmp)
                bodyOut.write(tmp)
                byteBuffer.clear()
                request.read(byteBuffer)
            }

            override fun onSucceeded(request: UrlRequest, info: UrlResponseInfo) {
                infoRef.set(info)
                latch.countDown()
            }

            override fun onFailed(request: UrlRequest, info: UrlResponseInfo?, e: CronetException) {
                error.compareAndSet(null, e)
                latch.countDown()
            }

            override fun onCanceled(request: UrlRequest, info: UrlResponseInfo?) {
                error.compareAndSet(null, RequestCancelled("Request cancelled"))
                latch.countDown()
            }
        }

        val builder = cronetEngine.newUrlRequestBuilder(url, callback, executor)
        for ((name, value) in headers) {
            if (name.lowercase(Locale.US) in skippedRequestHeaders) continue
            builder.addHeader(name, value)
        }
        if (body != null && body.isNotEmpty()) {
            builder.setUploadDataProvider(UploadDataProviders.create(body), executor)
            builder.setHttpMethod(method)
        } else if (!method.equals("GET", ignoreCase = true)) {
            builder.setHttpMethod(method)
        }

        val urlRequest = builder.build()
        if (id.isNotEmpty()) {
            liveRequests[id] = urlRequest
        }
        urlRequest.start()

        val finished = latch.await(timeoutMillis, TimeUnit.MILLISECONDS)
        liveRequests.remove(id, urlRequest)
        if (!finished) {
            urlRequest.cancel()
            throw SocketTimeoutException("Cronet request timed out after ${timeoutMillis}ms")
        }

        val failure = error.get()
        if (failure != null) {
            when (failure) {
                is RequestCancelled -> throw failure
                is SocketTimeoutException -> throw failure
                else -> throw IllegalStateException("Cronet failed: ${failure.message}", failure)
            }
        }

        val info = infoRef.get() ?: throw IllegalStateException("No response received")
        val elapsedMs = (System.nanoTime() - startedAt) / 1_000_000
        Log.d(
            TAG,
            "$method $host ${info.httpStatusCode} ${info.negotiatedProtocol} ${bodyOut.size()}B ${elapsedMs}ms",
        )

        val responseHeaders = HashMap<String, List<String>>()
        for ((key, values) in info.allHeaders) {
            val lower = key.lowercase(Locale.US)
            if (lower == "content-encoding" || lower == "content-length") continue
            responseHeaders[lower] = ArrayList(values)
        }

        return hashMapOf(
            "statusCode" to info.httpStatusCode,
            "statusMessage" to (info.httpStatusText ?: ""),
            "headers" to responseHeaders,
            "body" to bodyOut.toByteArray(),
            "protocol" to (info.negotiatedProtocol ?: ""),
        )
    }

    private class RequestCancelled(message: String) : Exception(message)
}
