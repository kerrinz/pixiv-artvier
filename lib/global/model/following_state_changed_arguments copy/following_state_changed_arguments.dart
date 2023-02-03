import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:artvier/config/enums.dart';

part 'following_state_changed_arguments.freezed.dart';

/// 用户关注状态发生变化时传递的参数
@Freezed(
  copyWith: true,
)
class FollowingStateChangedArguments with _$FollowingStateChangedArguments {
  const factory FollowingStateChangedArguments({
    required String userId,
    required UserFollowState state,
  }) = _FollowingStateChangedArguments;
}
