import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/api_app/api_user.dart';

/// 关注或已关注的按钮
/// [TextStyle] 可以在 [ButtonStyle]中定义
///

class FollowButton extends StatefulWidget {
  final bool isFollowed;
  final String userId;
  final Widget? child;
  final FollowButtonStyle? followedStyle;
  final FollowButtonStyle? unfollowedStyle;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;
  final double? pressedOpacity;
  final BorderRadius? borderRadius;

  const FollowButton({
    Key? key,
    required this.isFollowed,
    required this.userId,
    this.child,
    this.followedStyle,
    this.unfollowedStyle,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.pressedOpacity,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool isFollowed; // 是否关注，用于更新UI

  @override
  void initState() {
    super.initState();
    isFollowed = widget.isFollowed;
  }

  @override
  Widget build(BuildContext context) {
    Color color = isFollowed
          ? widget.followedStyle?.color ?? Theme.of(context).colorScheme.surfaceVariant
          : widget.unfollowedStyle?.color ?? Theme.of(context).colorScheme.primary;
    TextStyle textStyle = isFollowed
          ? widget.followedStyle?.textStyle ?? TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary)
          : widget.unfollowedStyle?.textStyle ?? TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onPrimary);
    return CupertinoButton(
      onPressed: () async {
        var isSucceed = await postFollow();
        if (isSucceed) {
          isFollowed = !isFollowed;
          (context as Element).markNeedsBuild(); // 更新UI
        }
      },
      padding: widget.padding,
      minSize: 0,
      alignment: widget.alignment,
      borderRadius: widget.borderRadius,
      pressedOpacity: widget.pressedOpacity,
      color: color,
      child: widget.child ?? Text(isFollowed ? "已关注" : "+ 关注", style: textStyle),
    );
  }

  // 关注或者取消关注用户
  Future postFollow() async {
    bool isSucceed;
    String msg;
    if (isFollowed) {
      isSucceed = await ApiUser().deleteFollowUser(userId: widget.userId);
      msg = isSucceed ? "取关成功" : "取关失败";
    } else {
      isSucceed = await ApiUser().addFollowUser(userId: widget.userId);
      msg = isSucceed ? "关注成功" : "关注失败";
    }
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    return isSucceed;
  }
}

/// [FollowButton] 的样式规则
class FollowButtonStyle {
  final Color? color;
  final TextStyle? textStyle;

  const FollowButtonStyle({
    this.color,
    this.textStyle, 
  });
}
