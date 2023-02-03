// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/request/http_requester.dart';

/// Http请求工具，但需要鉴权
final httpRequesterProvider = Provider((ref) => HttpRequester.withAuthorization(ref));

class ApiBase {
  final HttpRequester requester;

  ApiBase(this.requester);

  /// 通用加载更多/获取下一页数据
  /// 取得的jsonMap数据还需要 T.fromJson()转换
  Future<Map<String, dynamic>> nextUrlData(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      nextUrl,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return json.decode(res.data);
  }
}
