import 'dart:async';

import 'package:artvier/api_app/api_mute.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/list_notifier.dart';
import 'package:artvier/global/provider/requester_provider.dart';
import 'package:artvier/model_response/muted/muted_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 屏蔽列表
final mutedListProvider = AutoDisposeAsyncNotifierProvider<MutedListNotifier, MutedListResponse>(() {
  return MutedListNotifier();
});

/// 屏蔽列表的已勾选项索引
final muteCheckedListProvider = StateProvider.autoDispose<List<int>>((ref) {
  return [];
});

class MutedListNotifier extends BaseAutoDisposeAsyncNotifier<MutedListResponse>
    with ListAsyncNotifierMixin<MutedListResponse> {
  @override
  FutureOr<MutedListResponse> build() async {
    handleCancel(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<MutedListResponse> fetch() async {
    final result = await ApiMute(ref.read(httpRequesterProvider)).mutedList(cancelToken: cancelToken);
    final mutedUsers =
        result.mutedUsers.map((v) => v.copyWith(user: v.user.copyWith(isAccessBlockingUser: true))).toList();
    final mutedTags = result.mutedTags.map((v) => v.copyWith(isAccessBlocking: true)).toList();
    nextUrl = null;
    return result.copyWith(mutedUsers: mutedUsers, mutedTags: mutedTags);
  }

  Future<bool> mute({List<String>? userIds, List<String>? tags}) {
    return ApiMute(ref.read(httpRequesterProvider)).editMuted(addUseIds: userIds, addTags: tags);
  }

  Future<bool> unmute({List<String>? userIds, List<String>? tags}) {
    return ApiMute(ref.read(httpRequesterProvider)).editMuted(deleteUseIds: userIds, deleteTags: tags);
  }

  @override
  Future<bool> next() async {
    return false;
  }
}
