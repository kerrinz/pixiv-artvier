import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/config/enums.dart';

/// 关注或已关注的按钮，无状态
class UserFollowButtonStateless extends ConsumerWidget {
  const UserFollowButtonStateless({
    super.key,
    required this.followState,
    required this.userId,
    this.requestUnfollow,
    this.requestFollow,
  });

  final UserFollowState followState;

  final String userId;

  final Future<bool> Function()? requestUnfollow;
  final Future<bool> Function({required Restrict restrict})? requestFollow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final state = followState;
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

  void handlePressed(WidgetRef ref) {
    HapticFeedback.lightImpact();
    UserFollowState state = followState;
    if ([UserFollowState.requestingFollow, UserFollowState.requestingUnfollow].contains(state)) {
      return;
    }
    if (state == UserFollowState.followed) {
      if (requestUnfollow == null) return;
      requestUnfollow!()
          .then((value) => Fluttertoast.showToast(msg: "取关成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0))
          .onError(
            (error, stackTrace) => Fluttertoast.showToast(msg: "取关失败", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0),
          );
    } else {
      if (requestFollow == null) return;
      requestFollow!(restrict: Restrict.public)
          .then((value) => Fluttertoast.showToast(msg: "关注成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0))
          .onError((error, stackTrace) =>
              Fluttertoast.showToast(msg: "关注失败", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0));
    }
  }
}
