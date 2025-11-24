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

/// 屏蔽列表的已勾选项索引
final blockingCheckedListProvider = StateProvider.autoDispose<List<int>>((ref) {
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
    final mutedUsers =
        result.mutedUsers.map((v) => v.copyWith(user: v.user.copyWith(isAccessBlockingUser: true))).toList();
    final mutedTags = result.mutedTags.map((v) => v.copyWith(isAccessBlocking: true)).toList();
    nextUrl = null;
    return result.copyWith(mutedUsers: mutedUsers, mutedTags: mutedTags);
  }

  Future<bool> blocking({List<String>? userIds, List<String>? tags}) {
    return ApiBlocking(ref.read(httpRequesterProvider)).editBlocking(addUseIds: userIds, deleteTags: tags);
  }

  Future<bool> unblock({List<String>? userIds, List<String>? tags}) {
    return ApiBlocking(ref.read(httpRequesterProvider)).editBlocking(deleteUseIds: userIds, deleteTags: tags);
  }

  @override
  Future<bool> next() async {
    return false;
  }
}
