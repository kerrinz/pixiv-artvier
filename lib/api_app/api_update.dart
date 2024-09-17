import 'dart:convert';

import 'package:artvier/config/constants.dart';
import 'package:artvier/model_response/update/git_release.dart';
import 'package:dio/dio.dart';

import 'package:artvier/base/base_api.dart';

class ApiUpdate extends ApiBase {
  ApiUpdate(super.requester);

  /// 最新版本
  Future<GitRelease> lastRelease({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      '${CONSTANTS.app_repo_api}/releases/latest',
      queryParameters: {},
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return GitRelease.fromJson(json.decode(res.data));
  }

  /// 获取某个版本信息
  Future<GitRelease> releaseDetails(String tag, {CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      '${CONSTANTS.app_repo_api}/releases/tags/$tag',
      queryParameters: {},
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return GitRelease.fromJson(json.decode(res.data));
  }

  /// 历史版本
  Future<List<GitRelease>> historyReleases({int page = 1, int perPage = 10, CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      '${CONSTANTS.app_repo_api}/releases',
      queryParameters: {
        "page": page,
        "per_page": perPage,
      },
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return gitReleaseFromJson(json.decode(res.data));
  }
}
