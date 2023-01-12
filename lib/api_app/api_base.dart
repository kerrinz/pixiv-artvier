// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/request/oauth.dart';
import 'package:pixgem/request/refresh_token_interceptor.dart';
import 'package:pixgem/global/global.dart';

class ApiBase {
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://$BASE_URL_HOST',
    connectTimeout: 10000,
    receiveTimeout: 10000,
    sendTimeout: 10000,
    contentType: Headers.jsonContentType,
    headers: {
      "User-Agent": "PixivIOSApp/7.12.5 (iOS 14.6; iPhone11,2)",
      // "Cookie": " PHPSESSID=18975881_K0LvjfrJWGet7bXUKj8kvtI7ugSkmqrV;",
    },
  ));
  static const String BASE_URL_HOST = 'app-api.pixiv.net';

  // static const String BASE_URL_IP = '210.140.131.199'; // www.pixiv.net
  static const String BASE_URL_IP = '104.18.30.199';

  ApiBase() {
    String time = OAuth.getXClientTime(DateTime.now());
    String timeHash = OAuth.getXClientHash(xClientTime: time);
    dio.options.headers.addAll({
      "x-client-time": time,
      "x-client-hash": timeHash,
    });
  }

  /* 初始化 */
  static void init() {
    // 带上一些参数
    if (GlobalStore.currentAccount != null) {
      dio.options.headers["authorization"] = "Bearer ${GlobalStore.currentAccount!.accessToken}"; // token
      dio.options.headers["accept-language"] = "zh-cn"; // 接口返回的语言
    }
    // 添加拦截器
    dio.interceptors.clear();
    dio.interceptors.add(RefreshTokenInterceptor());
  }

  /* 更新全局dio请求头的token */
  void updateToken() {
    // 带上一些参数
    if (GlobalStore.currentAccount != null) {
      dio.options.headers["authorization"] = "Bearer ${GlobalStore.currentAccount!.accessToken}"; // token
    }
  }

  /// 通用加载更多/获取下一页数据
  /// 取得的jsonMap数据还需要 T.fromJson()转换
  Future<Map<String, dynamic>> nextUrlData({required String nextUrl, CancelToken? cancelToken}) async {
    Response res = await dio.get<String>(
      nextUrl,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return json.decode(res.data);
  }
}
