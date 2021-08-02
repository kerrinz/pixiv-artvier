import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/model_response/illusts/illust_comments.dart';
import 'package:pixgem/model_response/illusts/illust_ranking.dart';
import 'package:pixgem/model_response/illusts/illust_recommended.dart';
import 'package:pixgem/model_response/user/user_bookmarks_novel.dart';
import 'package:pixgem/model_response/user/user_bookmarks_illust.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/request/oauth.dart';
import 'package:pixgem/request/refresh_token_interceptor.dart';
import 'package:pixgem/store/global.dart';

class ApiApp {
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

  ApiApp() {
    String time = OAuth.getXClientTime(new DateTime.now());
    String timeHash = OAuth.getXClientHash(xClientTime: time);
    dio.options.headers.addAll({
      "x-client-time": time,
      "x-client-hash": timeHash,
    });
  }

  // 首次初始化
  void init() {
    // 带上一些参数
    if (GlobalStore.currentAccount != null) {
      dio.options.headers["authorization"] = "Bearer " + GlobalStore.currentAccount!.accessToken; // token
      dio.options.headers["accept-language"] = "zh-cn"; // 接口返回的语言
    }
    // 添加拦截器
    dio.interceptors.add(RefreshTokenInterceptor());
  }

  // 更新token
  void updateToken() {
    // 带上一些参数
    if (GlobalStore.currentAccount != null) {
      dio.options.headers["authorization"] = "Bearer " + GlobalStore.currentAccount!.accessToken; // token
    }
  }

  /* 首次获取推荐插画
   */
  Future<IllustRecommended> getFirstRecommendedIllust() async {
    Response res = await dio.get<String>(
      "/v1/illust/recommended",
      queryParameters: {
        "include_privacy_policy": true,
        "include_ranking_illusts": true,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
    );
    return IllustRecommended.fromJson(json.decode(res.data));
  }

  /* 获取下一页推荐插画（加载更多）
   */
  Future<IllustRecommended> getNextRecommendedIllust({required String nextUrl}) async {
    var time = OAuth.getXClientTime(new DateTime.now());
    Dio cacheDio = new Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      headers: {
        "User-Agent": "PixivIOSApp/7.12.5 (iOS 14.6; iPhone11,2)",
        "x-client-time": time,
        "x-client-hash": OAuth.getXClientHash(xClientTime: time),
        "authorization": "Bearer " + GlobalStore.currentAccount!.accessToken,
        "accept-language": "zh-cn",
      },
    ));
    Response res = await cacheDio.get<String>(
      nextUrl,
      options: Options(responseType: ResponseType.json),
    );
    return IllustRecommended.fromJson(json.decode(res.data));
  }

  /* 获取插画的评论
   * @illustId 插画id
   */
  Future<IllustComments> getIllustComments({required String illustId}) async {
    Response res = await dio.get<String>(
      "/v3/illust/comments",
      queryParameters: {
        "illust_id": illustId,
      },
      options: Options(responseType: ResponseType.json),
    );
    return IllustComments.fromJson(json.decode(res.data));
  }


  /* 获取插画排行榜
   * @mode RankingModeConstants
   */
  Future<IllustRanking> getIllustRanking({required String mode, int? offset, String? date}) async {
    var query = Map<String, dynamic>();
    query.addAll({
      "filter": "for_ios",
      "mode": mode,
    });
    if (offset != null) query["offset"] = offset;
    if (date != null) query["date"] = date;
    Response res = await dio.get<String>(
      "/v1/illust/ranking",
      queryParameters: query,
      options: Options(responseType: ResponseType.json),
    );
    return IllustRanking.fromJson(json.decode(res.data));
  }

  /* 获取插画排行榜的下一页数据
   * @mode RankingModeConstants
   */
  Future<IllustRanking> getNextIllustRanking(String url) async {
    Response res = await dio.get<String>(
      url,
      options: Options(responseType: ResponseType.json),
    );
    return IllustRanking.fromJson(json.decode(res.data));
  }

  /* 获取用户的详细资料 */
  Future<UserDetail> getUserDetail({required userId}) async {
    Response res = await dio.get<String>(
      "/v1/user/detail",
      queryParameters: {
        "user_id": userId,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
    );
    return UserDetail.fromJson(json.decode(res.data));
  }

  /* 获取用户收藏的插画列表
   */
  Future<UserBookmarksIllust> getUserBookmarksIllust(
      {required String userId, required String type, required int page}) async {
    Response res = await dio.get<String>(
      "/v1/user/bookmarks/illust",
      queryParameters: {
        "user_id": userId,
        "restrict": "public",
      },
      options: Options(responseType: ResponseType.json),
    );
    return UserBookmarksIllust.fromJson(json.decode(res.data));
  }

  /* 获取用户收藏的小说列表
   */
  Future<UserBookmarksNovel> getUserBookmarksNovel(
      {required String userId, required String type, required int page}) async {
    Response res = await dio.get<String>(
      "/v1/user/bookmarks/novel",
      queryParameters: {
        "user_id": userId,
        "restrict": "public",
      },
      options: Options(responseType: ResponseType.json),
    );
    return UserBookmarksNovel.fromJson(json.decode(res.data));
  }

  /* 收藏插画
   * @isPublic 是否公开
   * @illustId 插画id
   */
  Future<bool> addIllustBookmark({required String illustId, bool isPublic = true, List<String>? tags}) async {
    var baseData = {
      'illust_id': illustId,
      "restrict": isPublic ? "public" : "private",
    };
    FormData formData = new FormData();
    formData.fields.addAll(baseData.entries);
    if (tags != null) {
      tags.forEach((element) {
        formData.fields.add(new MapEntry("tags[]", element));
      });
    }
    Response res = await dio.post<String>(
      "/v2/illust/bookmark/add",
      data: formData,
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  /* 取消收藏插画
   * @illustId 插画id
   */
  Future<bool> deleteIllustBookmark({required String illustId}) async {
    Response res = await dio.post<String>(
      "/v1/illust/bookmark/delete",
      data: {
        'illust_id': illustId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
