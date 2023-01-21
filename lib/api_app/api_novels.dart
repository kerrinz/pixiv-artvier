import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/base/base_api.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/common/collection_detail.dart';
import 'package:pixgem/model_response/novels/common_novel_list.dart';

class ApiNovels extends ApiBase {
  ApiNovels(super.requester);

  /// 获取插画排行榜
  /// - [mode] NovelRankingMode
  /// - [date] 格式为 "yyyy-mm-dd"
  Future<CommonNovelList> getNovelRanking(
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
      nextUrl,
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
}
