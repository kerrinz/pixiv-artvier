/*
* 吸附顶端效果所需的Delegate */

import 'package:flutter/material.dart';

/// 参考 [FlexibleSpaceBar] 中的 [CollapseMode]
enum CollapseMode {
  parallax,

  pin,

  none,
}

class SliverWidgetPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  double maxHeight;

  double minHeight;

  CollapseMode collapseMode;

  SliverWidgetPersistentHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
    this.collapseMode = CollapseMode.parallax,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
