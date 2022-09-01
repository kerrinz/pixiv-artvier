import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/model_response/illusts/illust_trending_tags.dart';
import 'package:pixgem/model_response/illusts/illusts_search_result.dart';

import 'package:pixgem/api_app/api_base.dart';

class ApiSearch extends ApiBase {
  /* @description   搜索的热门标签
   */
  Future<IllustTrendingTags> getTrendingTags() async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/trending-tags/illust",
      queryParameters: {
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
    );
    return IllustTrendingTags.fromJson(json.decode(res.data));
  }

  /* @description   搜索插画
   * @parma
   * illustId 插画id
   */
  Future<IllustsSearchResult> searchIllust({
    required String searchWord,
    includeTranslatedTag = true,
    sort = "date_desc",
    searchTarget = "partial_match_for_tags",
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
    );
    return IllustsSearchResult.fromJson(json.decode(res.data));
  }
}
