import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/model/following_state_changed_arguments%20copy/following_state_changed_arguments.dart';

/// 全局Provider，用于通知某个用户的关注状态发生改变。
///
/// 使用方式：在其他地方使用`ref.listen()`监听该值的变化
///
/// ---
///
/// The global provider that notifies user following state changes.
///
/// How to use: use `ref.listen()` in other places to listen to the change of the value
///
/// ---
///
/// - Example：
/// ```dart
/// ref.listen<FollowingStateChangedArguments?>(globalIllustUserFollowStateChangedProvider, (previous, next) {
///   if (next != null && next.userId == userId) {
///     // do change state
///   }
/// });
///  ```
final globalFollowingStateChangedProvider = StateProvider<FollowingStateChangedArguments?>((ref) {
  return null;
});

/// "我"对某个用户的关注状态
class FollowNotifier extends BaseStateNotifier<UserFollowState> {
  FollowNotifier(super.state, {required super.ref, required this.userId});

  @override
  void dispose() {
    super.dispose();
  }

  final String userId;

  void setFollowState(UserFollowState newState) {
    state = newState;
  }

  void notifyGlobal() {
    ref
        .read(globalFollowingStateChangedProvider.notifier)
        .update((args) => FollowingStateChangedArguments(state: state, userId: userId));
  }

  /// 关注用户
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> follow({
    required Restrict restrict,
    bool throwException = true,
  }) async {
    var oldState = state;
    state = UserFollowState.requestingFollow;
    bool result = false;
    try {
      result = await ApiUser(requester).followUser(userId, restrict: restrict);
    } catch (e) {
      state = oldState;
      notifyGlobal();
      if (throwException) {
        rethrow;
      }
    }
    if (result) {
      state = UserFollowState.followed;
    } else {
      state = oldState;
    }
    notifyGlobal();
    return result;
  }

  /// 移除关注
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> unfollow({
    bool throwException = true,
  }) async {
    var oldState = state;
    state = UserFollowState.requestingUnfollow;
    bool result = false;
    try {
      result = await ApiUser(requester).unfollowUser(userId);
    } catch (e) {
      state = oldState;
      notifyGlobal();
      if (throwException) {
        rethrow;
      }
    }
    if (result) {
      state = UserFollowState.notFollow;
    } else {
      state = oldState;
    }
    notifyGlobal();
    return result;
  }
}
