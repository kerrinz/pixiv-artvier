import 'package:flutter/material.dart';

typedef CustomTabbarBuilder = Widget Function(Animation<double>? animation);

class CustomScrollableTabbar extends StatefulWidget {
  const CustomScrollableTabbar({
    super.key,
    required this.tabController,
    required this.builder,
  });

  final TabController tabController;

  final CustomTabbarBuilder builder;

  @override
  State<CustomScrollableTabbar> createState() => _CustomScrollableTabbarState();
}

class _CustomScrollableTabbarState extends State<CustomScrollableTabbar> {
  TabController get tabController => widget.tabController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: tabController.animation ?? tabController,
        builder: (context, child) {
          return widget.builder(tabController.animation);
        });
  }
}

// class SliverCustomScrollableTabbar extends CustomScrollableTabbar {}
