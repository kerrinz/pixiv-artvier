import 'dart:convert';

import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/config/ranking_mode_constants.dart';
import 'package:artvier/model_response/illusts/illust_comment_response.dart';
import 'package:artvier/model_response/illusts/illust_detail.dart';
import 'package:artvier/model_response/illusts/pixivision/spotlight_articles.dart';
import 'package:artvier/model_response/illusts/ugoira.dart';
import 'package:artvier/model_response/manga/manga_series_detail.dart';
import 'package:artvier/model_response/manga/recommended/manga_recommended.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:dio/dio.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/common/collection_detail.dart';
import 'package:artvier/model_response/illusts/common_illust_list.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:artvier/model_response/illusts/recommended/illust_recommended.dart';
import 'package:artvier/base/base_api.dart';

class ApiIllusts extends ApiBase {
  ApiIllusts(super.requester);

  /// 获取插画详情
  Future<IllustDetail> illustDetail(String illustId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/illust/detail",
      queryParameters: {
        "illust_id": illustId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return IllustDetail.fromJson(json.decode(res.data));
  }

  /// 获取漫画系列详情
  Future<MangaSeriesDetailResponse> mangaSeriesDetail(String illustSeriesId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/illust/series",
      queryParameters: {
        "illust_series_id": illustSeriesId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return MangaSeriesDetailResponse.fromJson(json.decode(res.data));
  }

  /// 获取插画动图信息
  Future<UgoiraMetadataResult> ugoiraMetadata(String illustId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      '/v1/ugoira/metadata',
      queryParameters: {
        "illust_id": illustId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return UgoiraMetadataResult.fromJson(json.decode(res.data));
  }

  /// 获取推荐插画
  Future<IllustRecommended> recommendedIllusts({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
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

  /// 获取推荐漫画
  Future<MangaRecommended> recommendedManga({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/manga/recommended",
      queryParameters: {
        "include_privacy_policy": true,
        "include_ranking_illusts": true,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return MangaRecommended.fromJson(json.decode(res.data));
  }

  /// 获取插画的评论
  /// - [illustId] 插画id
  Future<IllustComments> getIllustComments(String illustId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v3/illust/comments",
      queryParameters: {
        "illust_id": illustId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return IllustComments.fromJson(json.decode(res.data));
  }

  /// 获取插画的相关作品
  /// - [illustId] 插画id
  Future<CommonIllustList> getRelatedIllust(String illustId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v2/illust/related",
      queryParameters: {
        "illust_id": illustId,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 获取插画排行榜
  /// - mode: [IllustRankingMode]
  /// - date: yyyy-mm-dd
  Future<CommonIllustList> getIllustRanking(
      {required String mode, int? offset, String? date, CancelToken? cancelToken}) async {
    var query = <String, dynamic>{};
    query.addAll({
      "filter": "for_ios",
      "mode": mode,
    });
    if (offset != null) query["offset"] = offset;
    if (date != null) query["date"] = date;
    Response res = await requester.get<String>(
      "/v1/illust/ranking",
      queryParameters: query,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 获取漫画排行榜
  /// - mode: [MangaRankingMode]
  Future<CommonIllustList> mangaRanking(
      {required String mode, int? offset, String? date, CancelToken? cancelToken}) async {
    var query = <String, dynamic>{};
    query.addAll({
      "filter": "for_ios",
      "mode": mode,
    });
    if (offset != null) query["offset"] = offset;
    if (date != null) query["date"] = date;
    Response res = await requester.get<String>(
      "/v1/manga/ranking",
      queryParameters: query,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  // 获取插画亮点 Pixivision
  Future<SpotlightArticles> illustPixivision({isManga = false, CancelToken? cancelToken}) async {
    var query = <String, dynamic>{};
    query.addAll({
      "filter": "for_ios",
      "category": isManga ? "manga" : "all",
    });
    Response res = await requester.get<String>(
      "/v1/spotlight/articles",
      queryParameters: query,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return SpotlightArticles.fromJson(json.decode(res.data));
  }

  /// 高级收藏的时候，获取标签列表（含画作标签 + 用户收藏里已有的标签）
  Future<TheCollectionDetail> illustCollectionDetail(String illustId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v2/illust/bookmark/detail",
      queryParameters: {
        "illust_id": illustId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return TheCollectionDetail.fromJson(json.decode(res.data));
  }

  /// 收藏插画
  /// - [restrict] 隐私限制
  /// - [illustId] 插画id
  /// - [tags] 附加标签
  Future<bool> collectIllust(
      {required String illustId, Restrict? restrict, List<String>? tags, CancelToken? cancelToken}) async {
    var baseData = {
      'illust_id': illustId,
      "restrict": restrict?.name ?? Restrict.public.name,
    };
    FormData formData = FormData();
    formData.fields.addAll(baseData.entries);
    if (tags != null) {
      for (var element in tags) {
        formData.fields.add(MapEntry("tags[]", element));
      }
    }
    Response res = await requester.post<String>(
      "/v2/illust/bookmark/add",
      data: formData,
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return res.statusCode == 200;
  }

  /// 取消收藏插画
  /// - [illustId] 插画id
  Future<bool> uncollectIllust({required String illustId, CancelToken? cancelToken}) async {
    Response res = await requester.post<String>(
      "/v1/illust/bookmark/delete",
      data: {
        'illust_id': illustId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return res.statusCode == 200;
  }

  /// 获取下一页插画
  /// - [nextUrl] 下一页的链接地址
  Future<CommonIllustList> getNextIllusts(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      HttpHostOverrides().appApiUrl(nextUrl),
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 获取下一页评论
  /// - [nextUrl] 下一页的链接地址
  Future<IllustComments> nextIllustComments(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      HttpHostOverrides().appApiUrl(nextUrl),
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return IllustComments.fromJson(json.decode(res.data));
  }

  /// 获取评论的回复列表
  Future<IllustComments> commentReplies(int commentId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v2/illust/comment/replies",
      queryParameters: {
        "comment_id": commentId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return IllustComments.fromJson(json.decode(res.data));
  }

  /// 发布/回复评论
  /// - [illustId] 插画id
  /// - [comment] 评论内容
  /// - [stampId] 表情贴图id
  Future<IllustCommentResponse> sendComment({
    required String illustId,
    String? comment,
    int? stampId,
    int? parentCommentId,
    CancelToken? cancelToken,
  }) async {
    assert(comment != null || stampId != null);
    final data = {
      'illust_id': illustId,
      if (comment != null) 'comment': comment,
      if (stampId != null) 'stamp_id': stampId,
      if (parentCommentId != null) 'parent_comment_id': parentCommentId,
    };
    Response res = await requester.post<String>(
      "/v1/illust/comment/add",
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return IllustCommentResponse.fromJson(json.decode(res.data));
  }

  /// 删除评论
  /// - [illustId] 插画id
  Future<bool> deleteComment({required int commentId, CancelToken? cancelToken}) async {
    Response res = await requester.post<String>(
      "/v1/illust/comment/delete",
      data: {
        'comment_id': commentId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return res.statusCode == 200;
  }

  /// 获取 Pixivisiton 插画网页
  Future<String> illustPixvisionWebContent(String language, int id, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      HttpHostOverrides().pixivisionUrl("https://${HttpBaseOptions.pixivisionHost}/$language/a/$id"),
      options: Options(
        responseType: ResponseType.plain,
        headers: HttpHostOverrides().pixivisionHeaders,
      ),
      cancelToken: cancelToken,
    );
    return res.data;
  }
}
