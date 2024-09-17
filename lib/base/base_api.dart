import 'dart:convert';

import 'package:artvier/request/http_host_overrides.dart';
import 'package:dio/dio.dart';
import 'package:artvier/request/http_requester.dart';

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
