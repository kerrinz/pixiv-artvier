import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/novels/common_novel_list.dart';
import 'package:pixgem/model_response/user/bookmark/bookmark_tag_list.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/model_response/user/user_previews_list.dart';

import 'package:pixgem/api_app/api_base.dart';

class ApiUser extends ApiBase {
  /// 关注某个用户，可选公开或者私密
  Future<bool> addFollowUser(
      {required userId, String restrict = CONSTANTS.restrict_public, CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.post<String>(
      "/v1/user/follow/add",
      data: {
        "user_id": userId,
        "restrict": restrict,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  /// 取消关注某个用户
  Future<bool> deleteFollowUser({required userId, CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.post<String>(
      "/v1/user/follow/delete",
      data: {
        "user_id": userId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  /// 获取用户的详细资料
  Future<UserDetail> getUserDetail({required userId, CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/detail",
      queryParameters: {
        "user_id": userId,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return UserDetail.fromJson(json.decode(res.data));
  }

  /// 获取用户的漫画（或插画）作品列表
  Future<CommonIllustList> getUserIllusts(
      {required userId, String type = CONSTANTS.type_illusts, CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/illusts",
      queryParameters: {
        "user_id": userId,
        "filter": "for_ios",
        "type": type,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 获取用户的小说作品列表
  Future<CommonNovelList> getUserNovels({required userId, CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/novels",
      queryParameters: {
        "user_id": userId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 获取用户收藏的插画列表
  Future<CommonIllustList> getUserBookmarksIllust({
    required userId,
    String restrict = CONSTANTS.restrict_public,
    String? tag,
    CancelToken? cancelToken,
  }) async {
    assert(restrict == CONSTANTS.restrict_public || restrict == CONSTANTS.restrict_private);
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/bookmarks/illust",
      queryParameters: {
        "user_id": userId,
        "restrict": restrict,
        if (tag != null) "tag": tag,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 获取用户收藏的小说列表
  Future<CommonNovelList> getUserBookmarksNovel({
    required String userId,
    String restrict = CONSTANTS.restrict_public,
    String? tag,
    CancelToken? cancelToken,
  }) async {
    assert(restrict == CONSTANTS.restrict_public || restrict == CONSTANTS.restrict_private);
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/bookmarks/novel",
      queryParameters: {
        "user_id": userId,
        "restrict": restrict,
        if (tag != null) "tag": tag,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 获取某个用户的关注（用户）列表
  Future<UserPreviewsList> getUserFollowing(
      {required String userId, String restrict = CONSTANTS.restrict_public, CancelToken? cancelToken}) async {
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/following",
      queryParameters: {
        "user_id": userId,
        "restrict": restrict,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return UserPreviewsList.fromJson(json.decode(res.data));
  }

  /// 获取收藏插画的标签列表
  Future<BookmarkTagList> getBookmarkTags(
    WorksType worksType, {
    String restrict = CONSTANTS.restrict_public,
    CancelToken? cancelToken,
  }) async {
    assert(restrict == CONSTANTS.restrict_public || restrict == CONSTANTS.restrict_private);
    assert(worksType == WorksType.illust || worksType == WorksType.novel);
    String type = (worksType == WorksType.novel ? "novel" : "illust");
    Response res = await ApiBase.dio.get<String>(
      "/v1/user/bookmark-tags/$type",
      queryParameters: {
        "restrict": restrict,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return BookmarkTagList.fromJson(json.decode(res.data));
  }
}
