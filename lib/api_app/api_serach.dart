import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/illusts/illust_trending_tags.dart';

import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/model_response/novels/common_novel_list.dart';
import 'package:pixgem/model_response/user/common_user_previews_list.dart';

class ApiSearch extends ApiBase {
  /* @description   搜索的热门标签
   */
  Future<IllustTrendingTags> getTrendingTags({CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>("/v1/trending-tags/illust",
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
    includeTranslatedTag = true,
    sort = "date_desc",
    searchTarget = "partial_match_for_tags",
    CancelToken? cancelToken,
  }) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/search/illust",
      queryParameters: {
        "include_translated_tag_results": includeTranslatedTag,
        "merge_plain_keyword_results": true,
        "sort": sort,
        "word": searchWord,
        "search_target": searchTarget,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 搜索作品：小说
  Future<CommonNovelList> searcNovels(
    String searchWord, {
    includeTranslatedTag = true,
    sort = "date_desc",
    searchTarget = "partial_match_for_tags",
    CancelToken? cancelToken,
  }) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/search/novel",
      queryParameters: {
        "include_translated_tag_results": includeTranslatedTag,
        "merge_plain_keyword_results": true,
        "sort": sort,
        "word": searchWord,
        "search_target": searchTarget,
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
    Response res = await ApiBase.dio.get<String>(
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
