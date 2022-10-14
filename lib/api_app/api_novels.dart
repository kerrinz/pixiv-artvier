import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/model_response/novels/common_novel_list.dart';

class ApiNovels extends ApiBase {
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
    Response res = await ApiBase.dio.get<String>(
      "/v1/novel/ranking",
      queryParameters: query,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 获取下一页小说（用于懒加载）
  /// - [nextUrl] 下一页的链接地址
  Future<CommonNovelList> getNextNovels(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      nextUrl,
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }
}
