import 'package:dio/dio.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/request/api_app.dart';
import 'package:pixgem/request/oauth.dart';
import 'package:pixgem/store/global.dart';

class RefreshTokenInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    AccountProfile? profile = GlobalStore.currentAccount;
    if (profile == null) {
      // 未登录，打断施法
      print("未登录，打断施法");
    } else if (new DateTime.now().millisecondsSinceEpoch > (profile.expiredTimestamp ?? 0)) {
      // token过期了，先获取含新token的profile
      profile = await OAuth().refreshToken(profile.refreshToken);
      await OAuth().saveTokenToCurrent(profile); // 保存变更的配置
      // 接着给当前发起的请求更新token
      options.headers["authorization"] = "Bearer " + GlobalStore.currentAccount!.accessToken;
      handler.next(options); // continue
    } else {
      // 正常发起请求
      handler.next(options); // continue
    }
  }
}
