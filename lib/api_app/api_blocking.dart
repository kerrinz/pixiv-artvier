import 'dart:convert';

import 'package:artvier/model_response/blocking/blocking_list.dart';
import 'package:dio/dio.dart';
import 'package:artvier/base/base_api.dart';

class ApiBlocking extends ApiBase {
  ApiBlocking(super.requester);

  /// 获取屏蔽列表
  Future<BlockingListResponse> blockingList({CancelToken? cancelToken}) async {
    Response res = await requester.get<String>(
      "/v1/mute/list",
      options: Options(responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return BlockingListResponse.fromJson(json.decode(res.data));
  }

  /// 批量编辑屏蔽
  Future<bool> editBlocking({List<String>? addUseIds, List<String>? deleteUseIds, CancelToken? cancelToken}) async {
    Response res = await requester.post<String>(
      "/v1/mute/edit",
      data: {
        if (addUseIds != null && addUseIds.isNotEmpty) 'add_user_ids[]': addUseIds,
        if (deleteUseIds != null && deleteUseIds.isNotEmpty) 'delete_user_ids[]': deleteUseIds,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType, responseType: ResponseType.json),
      cancelToken: cancelToken,
    );
    return res.statusCode == 200;
  }
}
