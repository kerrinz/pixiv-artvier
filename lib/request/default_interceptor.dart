import 'package:dio/dio.dart';
import 'package:artvier/global/logger.dart';

class DefaultInterceptor extends InterceptorsWrapper {
  DefaultInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      if (err.type == DioExceptionType.cancel) {
        logger.i(err.type);
      } else {
        // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
        logger.w("Request error.\n" +
            "${err.toString()}\n" +
            "Request uri: ${err.requestOptions.uri}\n" +
            "Request params: ${err.requestOptions.queryParameters.toString()}\n" +
            "Request header: ${err.requestOptions.headers}\n");
      }
    } catch (e) {
      logger.w(err.response);
    }
    super.onError(err, handler);
  }
}
