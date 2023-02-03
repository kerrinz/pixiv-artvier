import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/storage/model/account_profile.dart';
import 'package:artvier/request/authorization_interceptor.dart';

/// 轻度封装的HTTP 请求工具。
///
/// HTTP request tool.
class HttpRequester {
  /// 默认构造函数，只使用默认配置
  HttpRequester(this.ref, {BaseOptions? baseOptions}) {
    _dio = Dio(baseOptions ?? _defaultBaseOptions);
  }

  /// 携带鉴权的构造函数
  HttpRequester.withAuthorization(this.ref, {BaseOptions? baseOptions}) {
    _dio = Dio(baseOptions ?? _defaultBaseOptions);
    _dio.interceptors.clear();
    _dio.interceptors.add(AuthorizationInterceptor(ref));
    // TODO: 可能可以使用watch替代，待测试
    if (ref.read(globalCurrentAccountProvider) != null) {
      resetAuthorization(accessToken: ref.read(globalCurrentAccountProvider)!.accessToken);
    }
    ref.listen<AccountProfile?>(globalCurrentAccountProvider, (previous, next) {
      if (next != null) {
        resetAuthorization(accessToken: next.accessToken);
      }
    });
  }

  late final Dio _dio;

  Dio get dio => _dio;

  final Ref ref;

  BaseOptions get baseOptions => _dio.options;

  /// 默认配置
  BaseOptions get _defaultBaseOptions => BaseOptions(
        baseUrl: HttpBaseOptions.baseUrl,
        connectTimeout: HttpBaseOptions.connectTimeout,
        receiveTimeout: HttpBaseOptions.receiveTimeout,
        sendTimeout: HttpBaseOptions.sendTimeout,
        headers: HttpBaseOptions.headers,
        contentType: Headers.jsonContentType,
      );

  /// 替换默认配置 BaseOption
  void replaceBaseOption(BaseOptions options) => _dio.options = options;

  /// 重置鉴权
  void resetAuthorization({required String accessToken}) {
    // reset accessToken
    baseOptions.headers["authorization"] = "Bearer $accessToken";
    replaceBaseOption(baseOptions);
  }

  Future<Response<T>> request<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.request(
      path,
      queryParameters: queryParameters,
      options: options?.copyWith(method: "GET"),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options?.copyWith(method: "POST"),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
