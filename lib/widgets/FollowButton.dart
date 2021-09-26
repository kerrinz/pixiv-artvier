import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/request/api_user.dart';

/// 关注或已关注的按钮
///

class FollowButton extends StatefulWidget {
  late final bool isFollowed;
  late final String userId;

  FollowButton({Key? key, required this.isFollowed, required this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FollowButtonState();
}

class FollowButtonState extends State<FollowButton> {
  late bool isFollowed; // 是否关注，用于更新UI

  @override
  void initState() {
    super.initState();
    this.isFollowed = widget.isFollowed;
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        var isSucceed = await postFollow();
        if (isSucceed) {
          this.isFollowed = !this.isFollowed;
          (context as Element).markNeedsBuild(); // 更新UI
        }
      },
      style: OutlinedButton.styleFrom(
        primary: isFollowed ? Theme.of(context).unselectedWidgetColor : Theme.of(context).colorScheme.onPrimary,
        backgroundColor: isFollowed ? Theme.of(context).bottomAppBarColor : Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Text(isFollowed ? "已关注" : "+ 关注"),
    );
  }

  // 关注或者取消关注用户
  Future postFollow() async {
    var isSucceed;
    String msg;
    if (this.isFollowed) {
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
