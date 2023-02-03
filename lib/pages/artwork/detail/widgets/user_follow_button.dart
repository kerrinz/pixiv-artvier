import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/following_state_changed_arguments%20copy/following_state_changed_arguments.dart';
import 'package:artvier/global/provider/follow_state_provider.dart';

/// 关注或已关注的按钮
class UserFollowButton extends ConsumerWidget with _FollowButtonLogic {
  UserFollowButton({
    Key? key,
    required this.followState,
    required this.userId,
  }) : super(key: key);

  final UserFollowState followState;

  final String userId;

  late final _userFollowProvider = StateNotifierProvider<FollowNotifier, UserFollowState>((ref) {
    return FollowNotifier(followState, ref: ref, userId: userId);
  });

  @override
  get userFollowProvider => _userFollowProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<FollowingStateChangedArguments?>(globalFollowingStateChangedProvider, (previous, next) {
      // 监听全局通知
      if (next != null) {
        ref.read(userFollowProvider.notifier).setFollowState(next.state);
      }
    });

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Map<UserFollowState, Color> colorMap = {
      UserFollowState.followed: colorScheme.surfaceVariant,
      UserFollowState.notFollow: colorScheme.primary,
      UserFollowState.requestingFollow: colorScheme.primary,
      UserFollowState.requestingUnfollow: colorScheme.surfaceVariant,
    };
    Map<UserFollowState, Color> textColorMap = {
      UserFollowState.followed: colorScheme.primary,
      UserFollowState.notFollow: colorScheme.surfaceVariant,
      UserFollowState.requestingFollow: colorScheme.surfaceVariant,
      UserFollowState.requestingUnfollow: colorScheme.primary,
    };
    Map<UserFollowState, String> textMap = {
      UserFollowState.followed: "已关注",
      UserFollowState.notFollow: "关注",
      UserFollowState.requestingFollow: "loading...",
      UserFollowState.requestingUnfollow: "loading...",
    };

    var state = ref.watch(userFollowProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
      child: CupertinoButton(
        onPressed: () => handlePressed(ref),
        minSize: 0,
        pressedOpacity: 1,
        alignment: Alignment.center,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        color: colorMap[state],
        child: SizedBox(
          height: 16,
          child: [UserFollowState.requestingFollow, UserFollowState.requestingUnfollow].contains(state)
              ? Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        color: textColorMap[state],
                      )),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(textMap[state]!, style: TextStyle(color: textColorMap[state], fontSize: 14.0, height: 1)),
                ),
        ),
      ),
    );
  }
}

mixin _FollowButtonLogic {
  StateNotifierProvider<FollowNotifier, UserFollowState> get userFollowProvider;

  void handlePressed(WidgetRef ref) {
    UserFollowState state = ref.read(userFollowProvider);
    if ([UserFollowState.requestingFollow, UserFollowState.requestingUnfollow].contains(state)) {
      return;
    }
    var notifier = ref.read(userFollowProvider.notifier);
    if (state == UserFollowState.followed) {
      try {
        notifier
            .unfollow()
            .then((value) => Fluttertoast.showToast(msg: "取关成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0));
      } catch (e) {
        Fluttertoast.showToast(msg: "取关失败", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
    } else {
      try {
        notifier
            .follow(restrict: Restrict.public)
            .then((value) => Fluttertoast.showToast(msg: "关注成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0));
      } catch (e) {
        Fluttertoast.showToast(msg: "关注失败", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
    }
  }
}
