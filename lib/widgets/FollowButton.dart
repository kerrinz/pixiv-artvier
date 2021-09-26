import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  late final bool isFollowed;
  late final Function onTap;

  FollowButton({Key? key, required this.isFollowed, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onTap();
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
}
