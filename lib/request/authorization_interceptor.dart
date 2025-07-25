import 'package:artvier/util/form_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/api_app/oauth.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  AuthorizationInterceptor(this.ref);

  final Ref ref;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      var profile = ref.read(globalCurrentAccountProvider);
      if (profile == null) {
        // 未登录，打断施法
      } else if (profile.accessToken == "" || DateTime.now().millisecondsSinceEpoch > (profile.expiredTimestamp ?? 0)) {
        // token过期了，先获取含新token的profile
        profile = await OAuth(ref).refreshToken(profile.refreshToken);
        // 更新本地帐号信息
        await OAuth(ref).saveTokenToLocalStorage(profile);
        // 给当前发起的请求附加新的token
        options.headers["authorization"] = "Bearer ${profile.accessToken}";
        handler.next(options); // continue
      } else {
        // 正常发起请求
        handler.next(options); // continue
      }
    } on DioException catch (e) {
      logger.e(e);
      handler.reject(e); // reject if error
    } catch (e) {
      logger.f(e);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      if (err.type == DioExceptionType.cancel) {
        logger.i('DioException type: ${err.type}\nRequest uri: ${err.requestOptions.uri}');
      } else {
        dynamic requestData = err.requestOptions.data;
        if (err.requestOptions.data != null && err.requestOptions.data is FormData) {
          requestData = FormUtil.formDataToJsonMap(err.requestOptions.data as FormData);
        }
        // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
        logger.w("Request error.\n" +
            "${err.toString()}\n" +
            "Request uri: ${err.requestOptions.uri}\n" +
            "Request params: ${err.requestOptions.queryParameters.toString()}\n" +
            "Request data: $requestData\n" +
            "Request header: ${err.requestOptions.headers}\n");
      }
    } catch (e) {
      logger.w(err.response);
    }
    super.onError(err, handler);
  }
}
