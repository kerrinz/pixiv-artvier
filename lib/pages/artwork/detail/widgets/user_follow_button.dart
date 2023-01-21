import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/model/following_state_changed_arguments%20copy/following_state_changed_arguments.dart';
import 'package:pixgem/global/provider/follow_state_provider.dart';

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
    this.ref = ref;
    ref.listen<FollowingStateChangedArguments?>(globalFollowingStateChangedProvider, (previous, next) {
      // 监听全局通知
      if (next != null) {
        ref.read(userFollowProvider.notifier).setFollowState(next.state);
      }
    });

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Map<UserFollowState, Color> colorMap = {
      UserFollowState.followed: Theme.of(context).colorScheme.surfaceVariant,
      UserFollowState.notFollow: colorScheme.primary,
      UserFollowState.requestingFollow: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.6),
      UserFollowState.requestingUnfollow: colorScheme.primary.withOpacity(0.6),
    };
    Map<UserFollowState, Color> textColorMap = {
      UserFollowState.followed: Theme.of(context).colorScheme.surfaceVariant,
      UserFollowState.notFollow: colorScheme.primary,
      UserFollowState.requestingFollow: Theme.of(context).colorScheme.surfaceVariant,
      UserFollowState.requestingUnfollow: colorScheme.primary,
    };
    Map<UserFollowState, String> textMap = {
      UserFollowState.followed: "已关注",
      UserFollowState.notFollow: "关注",
      UserFollowState.requestingFollow: "已关注.",
      UserFollowState.requestingUnfollow: "关注",
    };

    var state = ref.watch(userFollowProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
      child: CupertinoButton(
        onPressed: handlePressed,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minSize: 0,
        alignment: Alignment.center,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: colorMap[state],
        child: Text(textMap[state]!, style: TextStyle(color: textColorMap[state], fontSize: 14.0)),
      ),
    );
  }
}

mixin _FollowButtonLogic {
  late final WidgetRef ref;

  late final StateNotifierProvider<FollowNotifier, UserFollowState> userFollowProvider;

  void handlePressed() {
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
