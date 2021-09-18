import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/request/api_base.dart';

class ApiNewArtWork extends ApiBase {
  /* @description   获取关注用户的新作
   * @param
   *  illustId       插画id
   */
  Future<CommonIllust> getFollowsNewIllust({required String illustId}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v3/illust/comments",
      queryParameters: {
        "illust_id": illustId,
      },
      options: Options(responseType: ResponseType.json),
    );
    return CommonIllust.fromJson(json.decode(res.data));
  }
}
