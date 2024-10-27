// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:artvier/model_response/manga/manga_series_list.dart';
import 'package:artvier/model_response/novels/novel_series_list.dart';
import 'package:dio/dio.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust_list.dart';
import 'package:artvier/base/base_api.dart';
import 'package:artvier/model_response/novels/common_novel_list.dart';

class ApiNewArtWork extends ApiBase {
  ApiNewArtWork(super.requester);

  /// 关注用户的新作（插画+漫画）
  Future<CommonIllustList> followedNewestArtworks(RestrictAll restrict, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v2/illust/follow",
      queryParameters: {
        "restrict": restrict.name,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 关注用户的新作小说
  Future<CommonNovelList> followedNewestNovels(RestrictAll restrict, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/novel/follow",
      queryParameters: {
        "restrict": restrict.name,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 大家（全站）的新作（仅插画）
  Future<CommonIllustList> everybodysNewIllusts({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/illust/new",
      queryParameters: {
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 大家（全站）的新作（仅漫画）
  Future<CommonIllustList> everybodysNewManga({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/illust/new",
      queryParameters: {
        "content_type": "manga",
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 大家（全站）的新作（仅小说）
  Future<CommonNovelList> everybodysNewNovels({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/novel/new",
      queryParameters: {
        "content_type": "manga",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 好P友的新作（插画+漫画）
  Future<CommonIllustList> friendsNewestArtworks({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v2/illust/mypixiv",
      queryParameters: {
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 好P友的新作（小说）
  Future<CommonNovelList> friendsNewestNovels({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/novel/mypixiv",
      queryParameters: {
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 追更漫画系列
  Future<MangaSeriesListResponse> followedMangaSeries({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/watchlist/manga",
      queryParameters: {},
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return MangaSeriesListResponse.fromJson(json.decode(res.data));
  }

  /// 追更小说系列
  Future<NovelSeriesListResponse> followedNovelSeries({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/watchlist/novel",
      queryParameters: {},
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return NovelSeriesListResponse.fromJson(json.decode(res.data));
  }
}
