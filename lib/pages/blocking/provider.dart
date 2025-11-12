import 'dart:async';

import 'package:artvier/api_app/api_blocking.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/list_notifier.dart';
import 'package:artvier/global/provider/requester_provider.dart';
import 'package:artvier/model_response/blocking/blocking_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 屏蔽列表
final blockingListProvider = AutoDisposeAsyncNotifierProvider<BlockingListNotifier, BlockingListResponse>(() {
  return BlockingListNotifier();
});

/// 屏蔽用户列表的已勾选项索引
final blockingUsersCheckedListProvider = StateProvider.autoDispose<List<int>>((ref) {
  return [];
});

/// 屏蔽标签列表的已勾选项索引
final blockingTagsCheckedListProvider = StateProvider.autoDispose<List<int>>((ref) {
  return [];
});

class BlockingListNotifier extends BaseAutoDisposeAsyncNotifier<BlockingListResponse>
    with ListAsyncNotifierMixin<BlockingListResponse> {
  @override
  FutureOr<BlockingListResponse> build() async {
    handleCancel(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<BlockingListResponse> fetch() async {
    final result = await ApiBlocking(ref.read(httpRequesterProvider)).blockingList(cancelToken: cancelToken);
    nextUrl = null;
    return result;
  }

  Future<bool> unblock({List<String>? userIds, List<String>? tags}) {
    return ApiBlocking(ref.read(httpRequesterProvider)).editBlocking(deleteUseIds: userIds, deleteTags: tags);
  }

  @override
  Future<bool> next() async {
    return false;
  }
}
