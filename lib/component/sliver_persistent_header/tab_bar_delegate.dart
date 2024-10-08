/*
* TabBar实现吸附顶端效果所需的Delegate */
import 'package:flutter/material.dart';

const double kTabBarHeight = 46;

class SliverTabBarPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  EdgeInsets? padding;

  Color? backgroundColor;

  double? maxHeight;

  double? minHeight;

  SliverTabBarPersistentHeaderDelegate({
    required this.child,
    this.padding,
    this.backgroundColor,
    this.maxHeight,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor ?? BottomAppBarTheme.of(context).color,
      padding: padding,
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight ?? child.preferredSize.height;

  @override
  double get minExtent => minHeight ?? child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
