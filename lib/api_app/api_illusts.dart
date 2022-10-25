import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/artwork_collect_detail.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/illusts/illust_comments.dart';
import 'package:pixgem/model_response/illusts/illust_recommended.dart';
import 'package:pixgem/api_app/api_base.dart';

class ApiIllusts extends ApiBase {
  /// 获取插画详情
  Future<CommonIllust> getIllustDetail(String illustId, {CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      " /v1/illust/detail",
      queryParameters: {
        "illust_id": illustId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllust.fromJson(json.decode(res.data));
  }

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

  /// 获取插画的评论
  /// - [illustId] 插画id
  Future<IllustComments> getIllustComments(String illustId, {CancelToken? cancelToken}) async {
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

  /// 高级收藏的时候，获取标签列表（含画作标签 + 用户收藏里已有的标签）
  Future<ArtworkCollectDetail> getIllustCollectionTags(String illustId, {CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v2/illust/bookmark/detail",
      queryParameters: {
        "illust_id": illustId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return ArtworkCollectDetail.fromJson(json.decode(res.data));
  }

  /// 收藏插画
  /// - [isPublic] 是否公开
  /// - [illustId] 插画id
  /// - [tags] 附加标签
  Future<bool> addIllustBookmark(
      {required String illustId, String restrict = CONSTANTS.restrict_public, List<String>? tags, CancelToken? cancelToken}) async {
    var baseData = {
      'illust_id': illustId,
      "restrict": restrict,
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
