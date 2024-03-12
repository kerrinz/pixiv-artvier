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
      } else if (DateTime.now().millisecondsSinceEpoch > (profile.expiredTimestamp ?? 0)) {
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
    } on DioError catch (e) {
      logger.e(e);
      handler.reject(e); // reject if error
    } catch (e) {
      logger.wtf(e);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    try {
      if (err.type == DioErrorType.cancel) {
        logger.i(err.type);
      } else {
        logger.w(err.toString());
        // logger.w(json.decode(err.response!.data));
        // logger.w(err.requestOptions.queryParameters);
        // logger.w(err.requestOptions.data.toString());
        // logger.w(err.requestOptions.headers);
      }
    } catch (e) {
      logger.w(err.response);
    }
    super.onError(err, handler);
  }
}
