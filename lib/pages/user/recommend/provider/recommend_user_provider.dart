import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_user.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';

/// 推荐用户
final recommendUsersProvider =
    AutoDisposeAsyncNotifierProvider<RecommendUsersNotifier, List<CommonUserPreviews>>(() => RecommendUsersNotifier());

class RecommendUsersNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonUserPreviews>> {
  final CancelToken _cancelToken = CancelToken();

  String? nextUrl;

  @override
  FutureOr<List<CommonUserPreviews>> build() async {
    ref.onCancel(() {
      if (!_cancelToken.isCancelled) _cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonUserPreviews>> fetch() async {
    var result = await ApiUser(requester).recommendedUsers(cancelToken: _cancelToken);
    nextUrl = result.nextUrl;
    return result.userPreviews;
  }

  /// 失败后的重试，或者用于重新加载
  @override
  Future<void> reload() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 下拉刷新
  @override
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiUser(requester).nextPreviewUsers(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.users));

    return nextUrl != null;
  }
}
