import 'dart:convert';

import 'package:artvier/global/logger.dart';
import 'package:artvier/model_response/novels/marker_novel.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:dio/dio.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust_list.dart';
import 'package:artvier/model_response/novels/common_novel_list.dart';
import 'package:artvier/model_response/user/bookmark/bookmark_tag_list.dart';
import 'package:artvier/model_response/user/common_user_previews_list.dart';
import 'package:artvier/model_response/user/follow/folowing_detail.dart';
import 'package:artvier/model_response/user/user_detail.dart';
import 'package:artvier/model_response/user/user_previews_list.dart';

import 'package:artvier/base/base_api.dart';

class ApiUser extends ApiBase {
  ApiUser(super.requester);

  /// 获取用户的详细资料
  Future<UserDetail> userDetail(String userId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/user/detail",
      queryParameters: {
        "user_id": userId,
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    logger.d(res.data.toString());
    return UserDetail.fromJson(json.decode(res.data));
  }

  /// 关注某个用户，可选公开或者悄悄关注（私密）
  Future<bool> followUser(
    String userId, {
    Restrict restrict = Restrict.public,
    CancelToken? cancelToken,
  }) async {
    Response res = await requester.post<String>(
      "/v1/user/follow/add",
      data: {
        "user_id": userId,
        "restrict": restrict.name,
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
  Future<bool> unfollowUser(String userId, {CancelToken? cancelToken}) async {
    Response res = await requester.post<String>(
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

  /// 关注状态的详细信息（用于查询是否悄悄关注）
  Future<TheFollowingDetail> userFollowingDetail(String userId, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/user/follow/detail",
      queryParameters: {
        "user_id": userId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return TheFollowingDetail.fromJson(json.decode(res.data));
  }

  /// 获取用户的插画作品列表
  ///
  /// [worksType] = [WorksType.manga]]可切换为漫画作品
  Future<CommonIllustList> illustWorks(
      {required String userId, WorksType worksType = WorksType.illust, CancelToken? cancelToken}) async {
    assert([WorksType.illust, WorksType.manga].contains(worksType));
    String type = worksType == WorksType.illust ? CONSTANTS.type_illusts : CONSTANTS.type_manga;
    Response res = await requester.get<String>(
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

  /// 获取用户的漫画作品列表
  Future<CommonIllustList> mangaWorks({required String userId, CancelToken? cancelToken}) {
    return illustWorks(userId: userId, worksType: WorksType.manga, cancelToken: cancelToken);
  }

  /// 获取用户的小说作品列表
  Future<CommonNovelList> novelWorks({required String userId, CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
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
  Future<CommonIllustList> artworkCollections({
    required String userId,
    Restrict restrict = Restrict.public,
    String? tag,
    CancelToken? cancelToken,
  }) async {
    Response res = await requester.get<String>(
      "/v1/user/bookmarks/illust",
      queryParameters: {
        "user_id": userId,
        "restrict": restrict.name,
        if (tag != null) "tag": tag,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonIllustList.fromJson(json.decode(res.data));
  }

  /// 获取用户收藏的小说列表
  Future<CommonNovelList> novelCollections({
    required String userId,
    Restrict restrict = Restrict.public,
    String? tag,
    CancelToken? cancelToken,
  }) async {
    Response res = await requester.get<String>(
      "/v1/user/bookmarks/novel",
      queryParameters: {
        "user_id": userId,
        "restrict": restrict.name,
        if (tag != null) "tag": tag,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonNovelList.fromJson(json.decode(res.data));
  }

  /// 获取某个用户的关注（用户）列表
  Future<UserPreviewsList> userFollowings(
    String userId, {
    Restrict restrict = Restrict.public,
    CancelToken? cancelToken,
  }) async {
    Response res = await requester.get<String>(
      "/v1/user/following",
      queryParameters: {
        "user_id": userId,
        "restrict": restrict.name,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return UserPreviewsList.fromJson(json.decode(res.data));
  }

  /// 获取某个用户的好P友列表
  Future<UserPreviewsList> userFriends(
    String userId, {
    CancelToken? cancelToken,
  }) async {
    Response res = await requester.get<String>(
      "/v1/user/mypixiv",
      queryParameters: {
        "user_id": userId,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return UserPreviewsList.fromJson(json.decode(res.data));
  }

  /// 获取推荐用户列表
  Future<UserPreviewsList> recommendedUsers({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/user/recommended",
      queryParameters: {
        "filter": "for_ios",
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return UserPreviewsList.fromJson(json.decode(res.data));
  }

  /// 获取收藏作品的标签列表
  Future<BookmarkTagList> collectionTags(
    WorksType worksType, {
    Restrict restrict = Restrict.public,
    CancelToken? cancelToken,
  }) async {
    assert([WorksType.illust, WorksType.novel].contains(worksType));
    String type = (worksType == WorksType.novel ? "novel" : "illust");
    Response res = await requester.get<String>(
      "/v1/user/bookmark-tags/$type",
      queryParameters: {
        "restrict": restrict.name,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return BookmarkTagList.fromJson(json.decode(res.data));
  }

  /// 获取书签列表
  Future<MarkedNovelsResponse> markedNovels({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v2/novel/markers",
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return MarkedNovelsResponse.fromJson(json.decode(res.data));
  }

  /// 获取下一页用户
  Future<CommonUserPreviewsList> nextPreviewUsers(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      HttpHostOverrides().appApiUrl(nextUrl),
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return CommonUserPreviewsList.fromJson(json.decode(res.data));
  }

  /// 获取下一页标签
  Future<BookmarkTagList> nextTags(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      HttpHostOverrides().appApiUrl(nextUrl),
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return BookmarkTagList.fromJson(json.decode(res.data));
  }

  /// 获取下一页书签
  Future<MarkedNovelsResponse> nextMarkedNovels(String nextUrl, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      HttpHostOverrides().appApiUrl(nextUrl),
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return MarkedNovelsResponse.fromJson(json.decode(res.data));
  }
}
