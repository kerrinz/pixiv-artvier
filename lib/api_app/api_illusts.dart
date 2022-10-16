import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/illusts/illust_comments.dart';
import 'package:pixgem/model_response/illusts/illust_recommended.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/request/oauth.dart';
import 'package:pixgem/store/global.dart';

class ApiIllusts extends ApiBase {
  /// 获取推荐插画
  Future<IllustRecommended> getFirstRecommendedIllust({CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/illust/recommended",
      queryParameters: {
        "include_privacy_policy": true,
        "include_ranking_illusts": true,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return IllustRecommended.fromJson(json.decode(res.data));
  }

  /// ## 待废弃
  /// 获取下一页推荐插画（加载更多）
  Future<IllustRecommended> getNextRecommendedIllust({required String nextUrl, CancelToken? cancelToken}) async {
    var time = OAuth.getXClientTime(DateTime.now());
    Dio cacheDio = Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      headers: {
        "User-Agent": "PixivIOSApp/7.12.5 (iOS 14.6; iPhone11,2)",
        "x-client-time": time,
        "x-client-hash": OAuth.getXClientHash(xClientTime: time),
        "authorization": "Bearer ${GlobalStore.currentAccount!.accessToken}",
        "accept-language": "zh-cn",
      },
    ));
    Response res = await cacheDio.get<String>(
      nextUrl,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return IllustRecommended.fromJson(json.decode(res.data));
  }

  /// 获取插画的评论
  /// - [illustId] 插画id
  Future<IllustComments> getIllustComments({required String illustId, CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v3/illust/comments",
      queryParameters: {
        "illust_id": illustId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return IllustComments.fromJson(json.decode(res.data));
  }

  // 获取插画排行榜
  // - [mode] IllustRankingMode
  Future<CommonIllustList> getIllustRanking(
      {required String mode, int? offset, String? date, CancelToken? cancelToken}) async {
    var query = <String, dynamic>{};
    query.addAll({
      "filter": "for_ios",
      "mode": mode,
    });
    if (offset != null) query["offset"] = offset;
    if (date != null) query["date"] = date;
    Response res = await ApiBase.dio.get<String>(
      "/v1/illust/ranking",
      queryParameters: query,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 收藏插画
  /// - [isPublic] 是否公开
  /// - [illustId] 插画id
  Future<bool> addIllustBookmark(
      {required String illustId, bool isPublic = true, List<String>? tags, CancelToken? cancelToken}) async {
    var baseData = {
      'illust_id': illustId,
      "restrict": isPublic ? "public" : "private",
    };
    FormData formData = FormData();
    formData.fields.addAll(baseData.entries);
    if (tags != null) {
      for (var element in tags) {
        formData.fields.add(MapEntry("tags[]", element));
      }
    }
    Response res = await ApiBase.dio.post<String>(
      "/v2/illust/bookmark/add",
      data: formData,
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  /// 取消收藏插画
  /// - [illustId] 插画id
  Future<bool> deleteIllustBookmark({required String illustId, CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.post<String>(
      "/v1/illust/bookmark/delete",
      data: {
        'illust_id': illustId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  /// 获取下一页插画（用于懒加载）
  /// - [nextUrl] 下一页的链接地址
  Future<CommonIllustList> getNextIllusts(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      nextUrl,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }
}
