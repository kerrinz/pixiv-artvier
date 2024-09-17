import 'package:artvier/api_app/oauth.dart';
import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/global/provider/network_provider.dart';
import 'package:artvier/request/http_requester.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Http请求工具，但需要鉴权
final httpRequesterProvider = StateProvider<HttpRequester>((ref) {
  var directEnable = ref.watch(globalDirectConnectionProvider.select((value) => value));
  if (directEnable) {
    return HttpRequester.withAuthorization(
      ref,
      baseOptions: HttpRequester.defaultBaseOptions
          .copyWith(baseUrl: "https://${HttpBaseOptions.appApiIp}", headers: HttpBaseOptions.appApiHeaders),
    );
  } else {
    return HttpRequester.withAuthorization(
      ref,
      baseOptions: HttpRequester.defaultBaseOptions
          .copyWith(baseUrl: "https://${HttpBaseOptions.appApiHost}", headers: HttpBaseOptions.appApiHeaders),
    );
  }
});

/// 鉴权专用的Http请求工具
final oAuthHttpRequesterProvider = StateProvider.autoDispose<HttpRequester>((ref) {
  bool directEnable = ref.watch(globalDirectConnectionProvider.select((value) => value));
  if (directEnable) {
    return HttpRequester(
      ref,
      baseOptions: OAuth.baseOptions.copyWith(baseUrl: "https://${HttpBaseOptions.oauthIp}"),
    );
  } else {
    return HttpRequester(ref, baseOptions: OAuth.baseOptions);
  }
});

/// 其他用途的Http请求工具
final originHttpRequesterProvider = StateProvider.autoDispose<HttpRequester>((ref) {
  return HttpRequester(ref, baseOptions: HttpRequester.defaultBaseOptions.copyWith(baseUrl: ''));
});
