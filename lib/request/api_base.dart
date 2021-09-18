import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/illusts/illust_comments.dart';
import 'package:pixgem/model_response/illusts/illust_ranking.dart';
import 'package:pixgem/model_response/illusts/illust_recommended.dart';
import 'package:pixgem/model_response/illusts/illust_trending_tags.dart';
import 'package:pixgem/model_response/illusts/illusts_search_result.dart';
import 'package:pixgem/model_response/user/user_bookmarks_novel.dart';
import 'package:pixgem/model_response/user/user_bookmarks_illust.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/request/oauth.dart';
import 'package:pixgem/request/refresh_token_interceptor.dart';
import 'package:pixgem/store/global.dart';

class ApiBase {
  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'https://' + BASE_URL_HOST,
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
    String time = OAuth.getXClientTime(new DateTime.now());
    String timeHash = OAuth.getXClientHash(xClientTime: time);
    dio.options.headers.addAll({
      "x-client-time": time,
      "x-client-hash": timeHash,
    });
  }

  /* 首次初始化 */
  void init() {
    // 带上一些参数
    if (GlobalStore.currentAccount != null) {
      dio.options.headers["authorization"] = "Bearer " + GlobalStore.currentAccount!.accessToken; // token
      dio.options.headers["accept-language"] = "zh-cn"; // 接口返回的语言
    }
    // 添加拦截器
    dio.interceptors.add(RefreshTokenInterceptor());
  }

  /* 更新全局dio请求头的token */
  void updateToken() {
    // 带上一些参数
    if (GlobalStore.currentAccount != null) {
      dio.options.headers["authorization"] = "Bearer " + GlobalStore.currentAccount!.accessToken; // token
    }
  }

  /* @description   通用：加载更多/获取下一页数据
  *  取得的jsonMap数据还需要 T.fromJson()转换
  * @parma
  *   nextUrl 下一页的链接地址
  */
  Future<Map<String, dynamic>> getNextUrlData({required String nextUrl}) async {
    Response res = await dio.get<String>(
      nextUrl,
      options: Options(responseType: ResponseType.json),
    );
    return json.decode(res.data);
  }
}
