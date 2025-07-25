import 'dart:convert';

import 'package:artvier/global/logger.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/model_response/novels/novel_detail.dart';
import 'package:artvier/model_response/novels/novel_series_detail.dart';
import 'package:artvier/model_response/novels/recommended/novels_recommended.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/util/string_util.dart';
import 'package:dio/dio.dart';
import 'package:artvier/base/base_api.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/common/collection_detail.dart';
import 'package:artvier/model_response/novels/common_novel_list.dart';

class ApiNovels extends ApiBase {
  ApiNovels(super.requester);

  /// 获取小说系列详情
  Future<NovelDetail> novelDetail(String novelId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v2/novel/detail",
      queryParameters: {
        "novel_id": novelId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return NovelDetail.fromJson(json.decode(res.data));
  }

  /// 获取小说详情(WebView)
  Future<NovelDetailWebView> novelDetailWebView(String novelId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/webview/v2/novel?id=$novelId",
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    NovelDetailWebView result;
    final data = res.data.toString();
    try {
      final startAt = data.indexOf("Object.defineProperty(window, 'pixiv'");
      final novelStartAt = data.indexOf("novel", startAt);
      final authorDetailsStartAt = data.indexOf("authorDetails", startAt);
      final novelJson = StringUtil.extractJsonValueInJs(data, "novel", startAt: novelStartAt)
          // 转化 List 和 Map 格式
          ?.replaceFirst('"illusts": []', '"illusts":{}')
          .replaceFirst('"images": []', '"images":{}')
          .replaceFirst('"illusts":[]', '"illusts":{}')
          .replaceFirst('"images":[]', '"images":{}');
      final authorDetailsJson = StringUtil.extractJsonValueInJs(data, "authorDetails", startAt: authorDetailsStartAt);
      result = NovelDetailWebView.fromJson(json.decode('{"novel":$novelJson,"authorDetails":$authorDetailsJson}'));
    } catch (e) {
      // log(objStr);
      logger.e(e);
      rethrow;
    }
    return result;
  }

  /// 获取小说系列详情
  Future<NovelSeriesDetailResponse> novelSeriesDetail(String novelSeriesId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v2/novel/series",
      queryParameters: {
        "series_id": novelSeriesId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return NovelSeriesDetailResponse.fromJson(json.decode(res.data));
  }

  /// 获取推荐小说
  Future<NovelsRecommended> recommendedNovels({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/novel/recommended",
      queryParameters: {
        "include_privacy_policy": true,
        "include_ranking_novels": true,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return NovelsRecommended.fromJson(json.decode(res.data));
  }

  /// 获取小说排行榜
  /// - [mode] NovelRankingMode
  /// - [date] 格式为 "yyyy-mm-dd"
  Future<CommonNovelList> rankingNovels(
      {required String mode, int? offset, String? date, CancelToken? cancelToken}) async {
    var query = <String, dynamic>{};
    query.addAll({
      "mode": mode,
    });
    if (offset != null) query["offset"] = offset;
    if (date != null) query["date"] = date;
    Response res = await requester.get<String>(
      "/v1/novel/ranking",
      queryParameters: query,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 获取下一页小说（用于懒加载）
  /// - [nextUrl] 下一页的链接地址
  Future<CommonNovelList> nextNovels(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      HttpHostOverrides().appApiUrl(nextUrl),
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 高级收藏的时候，获取标签列表（含画作标签 + 用户收藏里已有的标签）
  Future<TheCollectionDetail> novelCollectionDetail(String novelId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v2/novel/bookmark/detail",
      queryParameters: {
        "novel_id": novelId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return TheCollectionDetail.fromJson(json.decode(res.data));
  }

  /// 收藏小说
  /// - [restrict] 隐私限制
  /// - [novelId] 小说id
  /// - [tags] 附加标签
  Future<bool> collectNovel(
      {required String novelId, Restrict? restrict, List<String>? tags, CancelToken? cancelToken}) async {
    var baseData = {
      'novel_id': novelId,
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
      "/v2/novel/bookmark/add",
      data: formData,
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return res.statusCode == 200;
  }

  /// 移除收藏
  /// - [novel] 小说id
  Future<bool> uncollectNovel({required String novelId, CancelToken? cancelToken}) async {
    Response res = await requester.post<String>(
      "/v1/novel/bookmark/delete",
      data: {
        'novel_id': novelId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return res.statusCode == 200;
  }

  /// 添加书签
  /// - [restrict] 隐私限制
  /// - [novelId] 小说id
  /// - [tags] 附加标签
  Future<bool> markerNovel({required String novelId, required int page, CancelToken? cancelToken}) async {
    final baseData = {
      'novel_id': novelId,
      "page": page.toString(),
    };
    FormData formData = FormData();
    formData.fields.addAll(baseData.entries);
    Response res = await requester.post<String>(
      "/v1/novel/marker/add",
      data: formData,
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return res.statusCode == 200;
  }

  /// 移除书签
  /// - [novel] 小说id
  Future<bool> unmarkerNovel({required String novelId, CancelToken? cancelToken}) async {
    Response res = await requester.post<String>(
      "/v1/novel/marker/delete",
      data: {
        'novel_id': novelId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return res.statusCode == 200;
  }
}
