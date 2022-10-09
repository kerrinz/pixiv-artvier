import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/user/user_bookmarks_novel.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/model_response/user/user_previews_list.dart';

import 'package:pixgem/api_app/api_base.dart';

class ApiUser extends ApiBase {
  // 关注某个用户，可选公开或者私密
  Future<bool> addFollowUser({required userId, String restrict = CONSTANTS.restrict_public}) async {
    Response res = await ApiBase.dio.post<String>(
      "/v1/user/follow/add",
      data: {
        "user_id": userId,
        "restrict": restrict,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  // 取消关注某个用户
  Future<bool> deleteFollowUser({required userId}) async {
    Response res = await ApiBase.dio.post<String>(
      "/v1/user/follow/delete",
      data: {
        "user_id": userId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  /* 获取用户的详细资料 */
  Future<UserDetail> getUserDetail({required userId}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/detail",
      queryParameters: {
        "user_id": userId,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
    );
    return UserDetail.fromJson(json.decode(res.data));
  }

  /* 获取用户的作品列表 */
  Future<CommonIllustList> getUserIllusts({required userId, String type = CONSTANTS.type_illusts}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/illusts",
      queryParameters: {
        "user_id": userId,
        "filter": "for_ios",
        "type": type,
      },
      options: Options(responseType: ResponseType.json),
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /* 获取用户收藏的插画列表
   */
  Future<CommonIllustList> getUserBookmarksIllust(
      {required userId, String restrict = CONSTANTS.restrict_public}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/bookmarks/illust",
      queryParameters: {
        "user_id": userId,
        "restrict": restrict,
      },
      options: Options(responseType: ResponseType.json),
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /* 获取用户收藏的小说列表
   */
  Future<UserBookmarksNovel> getUserBookmarksNovel({required String userId}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/bookmarks/novel",
      queryParameters: {
        "user_id": userId,
        "restrict": "public",
      },
      options: Options(responseType: ResponseType.json),
    );
    return UserBookmarksNovel.fromJson(json.decode(res.data));
  }

  /* 获取某个用户的关注（用户）列表
   */
  Future<UserPreviewsList> getUserFollowing(
      {required String userId, String restrict = CONSTANTS.restrict_public}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/following",
      queryParameters: {
        "user_id": userId,
        "restrict": restrict,
      },
      options: Options(responseType: ResponseType.json),
    );
    return UserPreviewsList.fromJson(json.decode(res.data));
  }
}
