/*
* TabBar实现吸附顶端效果所需的Delegate */
import 'package:flutter/material.dart';

class SliverTabBarPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  Color? backgroundColor;

  SliverTabBarPersistentHeaderDelegate({required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor ?? Theme.of(context).bottomAppBarColor,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
