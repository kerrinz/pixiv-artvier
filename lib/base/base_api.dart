// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/global/provider/network_provider.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/request/http_requester.dart';

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

class ApiBase {
  final HttpRequester requester;

  ApiBase(this.requester);

  /// 通用加载更多/获取下一页数据
  /// 取得的jsonMap数据还需要 T.fromJson()转换
  Future<Map<String, dynamic>> nextUrlData(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      HttpHostOverrides().appApiUrl(nextUrl),
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return json.decode(res.data);
  }
}
