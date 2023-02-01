import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/base/base_provider/base_notifier.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/logger.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';

/// 关注列表的筛选
final userFollowingFilterProvider = StateProvider.autoDispose.family<Restrict, String>((ref, userId) {
  return Restrict.public;
});

// TODO: 可能是riverpod的bug，
// [AutoDisposeFamilyAsyncNotifier] 里的build函数带有ref.watch()会导致Provider重建Error，而不是预期的Loading；
// 但去掉family就不会Error
class UserFollowingNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonUserPreviews>> {
  UserFollowingNotifier({required this.userId});

  final String userId;

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
  Future<List<CommonUserPreviews>> fetch() async {
    var restrict = ref.watch(userFollowingFilterProvider(userId));

    try {
      var result = await ApiUser(requester).userFollowings(userId, restrict: restrict, cancelToken: _cancelToken);
      nextUrl = result.nextUrl;
      return result.userPreviews;
    } catch (e) {
      if (!(e is DioError && e.type == DioErrorType.cancel)) logger.e(e);
      rethrow;
    }
  }

  /// 失败后的重试，或者用于重新加载
  Future<void> reload() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 下拉刷新
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
