import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/request/api_base.dart';

class ApiNewArtWork extends ApiBase {
  static const String restrict_all = "all";
  static const String restrict_public = "public";
  static const String restrict_private = "private";

  static const String type_illust = "illust";
  static const String type_manga = "manga";

  /* @description   获取关注用户的新作
   * @param
   *  restrict 查询的限制，全部、公开、私人
   */
  Future<CommonIllustList> getFollowsNewIllusts(String restrict) async {
    Response res = await ApiBase.dio.get<String>(
      "/v2/illust/follow",
      queryParameters: {
        "restrict": restrict,
      },
      options: Options(responseType: ResponseType.json),
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /* @description   获取大家的新作
   * @param
   *  type 作品类型：插画、漫画
   */
  Future<CommonIllustList> getEveryOnesNewIllusts(String type) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/illust/new",
      queryParameters: {
        "content_type": type,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /* @description   好P友的新作
   * @param
   */
  Future<CommonIllustList> getPFriendsIllusts(String type) async {
    Response res = await ApiBase.dio.get<String>(
      "/v2/illust/mypixiv",
      queryParameters: {
        "content_type": type,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  void getFollowsNewNovels() {}
  void getEveryOnesNewNovels() {}
  void getPFriendsNovels() {}

}
