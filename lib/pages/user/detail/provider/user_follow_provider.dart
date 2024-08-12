import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/following_state_changed_arguments%20copy/following_state_changed_arguments.dart';
import 'package:artvier/global/provider/follow_state_provider.dart';

/// 用户详情页的关注状态
final userFollowStateProvider =
    StateNotifierProvider.autoDispose.family<FollowNotifier, UserFollowState, String>((ref, userId) {
  // 监听全局的关注通知
  ref.listen<FollowingStateChangedArguments?>(globalFollowingStateChangedProvider, (previous, next) {
    if (next != null && next.userId == userId) {
      ref.notifier.setFollowState(next.state);
    }
  });

  return FollowNotifier(UserFollowState.notFollow, ref: ref, userId: userId);
});
