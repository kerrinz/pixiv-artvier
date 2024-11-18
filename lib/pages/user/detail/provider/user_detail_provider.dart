import 'dart:async';

import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/following_state_changed_arguments%20copy/following_state_changed_arguments.dart';
import 'package:artvier/global/provider/follow_state_provider.dart';
import 'package:artvier/pages/user/detail/provider/user_follow_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_user.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/model_response/user/user_detail.dart';

/// 用户详情
final userDetailProvider =
    AutoDisposeAsyncNotifierProviderFamily<UserDetailNotifier, UserDetail, String>(UserDetailNotifier.new);

/// 用户详情
/// 关注状态将转换到 [userFollowStateProvider] 中
/// arg为userId
class UserDetailNotifier extends BaseAutoDisposeFamilyAsyncNotifier<UserDetail, String> {
  late final String userId;

  final CancelToken _cancelToken = CancelToken();

  @override
  FutureOr<UserDetail> build(String arg) async {
    ref.onCancel(() {
      if (!_cancelToken.isCancelled) _cancelToken.cancel();
    });
    userId = arg;
    return fetch();
  }

  /// 初始化数据
  @override
  Future<UserDetail> fetch() async {
    var result = await ApiUser(requester).userDetail(userId);
    var followState = (result.user.isFollowed ?? false) ? UserFollowState.followed : UserFollowState.notFollow;
    // 初始化关注状态
    ref.read(userFollowStateProvider(userId).notifier).setFollowState(followState);
    // 同步到全局以纠正数据
    ref
        .read(globalFollowingStateChangedProvider.notifier)
        .update((args) => FollowingStateChangedArguments(state: followState, userId: userId));
    return result;
  }

  /// 下拉刷新
  @override
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
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
}
