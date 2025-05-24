import 'dart:convert';

import 'package:artvier/model_response/common/predictive_search.dart';
import 'package:dio/dio.dart';
import 'package:artvier/model_response/illusts/common_illust_list.dart';
import 'package:artvier/model_response/illusts/illust_trending_tags.dart';

import 'package:artvier/base/base_api.dart';
import 'package:artvier/model_response/novels/common_novel_list.dart';
import 'package:artvier/model_response/user/common_user_previews_list.dart';

class ApiSearch extends ApiBase {
  ApiSearch(super.requester);

  /// 插画+漫画的热门标签/趋势
  Future<IllustTrendingTags> artworksTrendingTags({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>("/v1/trending-tags/illust",
        queryParameters: {
          "filter": "for_ios",
        },
        options: Options(responseType: ResponseType.json),
        cancelToken: cancelToken);
    return IllustTrendingTags.fromJson(json.decode(res.data));
  }

  /// 小说的热门标签/趋势
  /// （数据模型没弄错）
  Future<IllustTrendingTags> novelsTrendingTags({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>("/v1/trending-tags/novel",
        queryParameters: {
          "filter": "for_ios",
        },
        options: Options(responseType: ResponseType.json),
        cancelToken: cancelToken);
    return IllustTrendingTags.fromJson(json.decode(res.data));
  }

  /// 搜索作品：插画漫画
  Future<CommonIllustList> searchArtworks(
    String searchWord, {
    // 时间排序
    String sort = ApiSearchConstants.dateDesc,
    // 匹配规则
    String match = ApiSearchConstants.tagPartialMatch,
    // AI作品: 0显示,1隐藏
    int? searchAiType,
    // 作品的发布时间范围，格式“yyyy-MM-dd"
    String? startDate,
    String? endDate,
    includeTranslatedTag = true,
    CancelToken? cancelToken,
  }) async {
    assert([ApiSearchConstants.dateDesc, ApiSearchConstants.dateAsc].contains(sort));
    assert(
      [ApiSearchConstants.tagPartialMatch, ApiSearchConstants.tagPerfectMatch, ApiSearchConstants.titleAndDescription]
          .contains(match),
    );
    Response res = await requester.get<String>(
      "/v1/search/illust",
      queryParameters: {
        "include_translated_tag_results": includeTranslatedTag,
        "merge_plain_keyword_results": true,
        "word": searchWord,
        "sort": sort,
        "search_target": match,
        "search_ai_type": searchAiType ?? 0,
        if (startDate != null && startDate != '') "start_date": startDate,
        if (endDate != null && endDate != '') "end_date": endDate,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 搜索作品：小说
  Future<CommonNovelList> searchNovels(
    String searchWord, {
    // 时间排序
    String sort = ApiSearchConstants.dateDesc,
    // AI作品: 0显示,1隐藏
    int? searchAiType,
    // 匹配规则
    String match = ApiSearchConstants.tagPartialMatch,
    // 作品的发布时间范围，格式“yyyy-MM-dd"
    String? startDate,
    String? endDate,
    includeTranslatedTag = true,
    CancelToken? cancelToken,
  }) async {
    assert([ApiSearchConstants.dateDesc, ApiSearchConstants.dateAsc].contains(sort));
    assert(
      [ApiSearchConstants.tagPartialMatch, ApiSearchConstants.tagPerfectMatch, ApiSearchConstants.titleAndDescription]
          .contains(match),
    );
    Response res = await requester.get<String>(
      "/v1/search/novel",
      queryParameters: {
        "include_translated_tag_results": includeTranslatedTag,
        "merge_plain_keyword_results": true,
        "sort": sort,
        "word": searchWord,
        "search_target": match,
        "search_ai_type": searchAiType ?? 0,
        if (startDate != null && startDate != '') "start_date": startDate,
        if (endDate != null && endDate != '') "end_date": endDate,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 搜索用户
  Future<CommonUserPreviewsList> searchUsers(
    String searchWord, {
    CancelToken? cancelToken,
  }) async {
    Response res = await requester.get<String>(
      "/v1/search/user",
      queryParameters: {
        "word": searchWord,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonUserPreviewsList.fromJson(json.decode(res.data));
  }

  /// 预测搜索，插画漫画
  Future<PredictiveSearchWorks> predictiveSearchIllust(
    String searchWord, {
    CancelToken? cancelToken,
  }) async {
    Response res = await requester.get<String>(
      "/v2/search/autocomplete",
      queryParameters: {
        "word": searchWord,
        "merge_plain_keyword_results": true,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return PredictiveSearchWorks.fromJson(json.decode(res.data));
  }

  /// 预测搜索，小说
  Future<PredictiveSearchWorks> predictiveSearchNovels(
    String searchWord, {
    CancelToken? cancelToken,
  }) async {
    Response res = await requester.get<String>(
      "/v2/search/autocomplete",
      queryParameters: {
        "merge_plain_keyword_results": true,
        "word": searchWord,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return PredictiveSearchWorks.fromJson(json.decode(res.data));
  }

  /// 预测搜索，用户
  Future<CommonUserPreviewsList> predictiveSearchUsers(
    String searchWord, {
    CancelToken? cancelToken,
  }) async {
    Response res = await requester.get<String>(
      "/v1/search/user",
      queryParameters: {
        "word": searchWord,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonUserPreviewsList.fromJson(json.decode(res.data));
  }
}

/// 搜索的一些常量
class ApiSearchConstants {
  /// 标签部分匹配
  static const tagPartialMatch = "partial_match_for_tags";

  /// 标签完全匹配
  static const tagPerfectMatch = "exact_match_for_tags";

  /// 标题和简介
  static const titleAndDescription = "title_and_caption";

  /// 时间升序（由旧到新）
  static const dateAsc = "date_asc";

  /// 时间降序（最新作品）
  static const dateDesc = "date_desc";
}
