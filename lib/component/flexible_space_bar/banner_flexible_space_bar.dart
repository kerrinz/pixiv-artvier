import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'dart:ui' as ui;

class BannerFlexibleSpaceBar extends FlexibleSpaceBar {
  final double bannerHeight;

  final Widget? bottomExtentChild;

  final List<Widget>? children;

  const BannerFlexibleSpaceBar({
    Key? key,
    required this.bannerHeight,

    /// banner widget in [Positioned]
    Widget? banner,
    this.children,
    this.bottomExtentChild,
    Widget? title,
    EdgeInsetsGeometry? titlePadding,
    CollapseMode collapseMode = CollapseMode.parallax,
    List<StretchMode> stretchModes = const <StretchMode>[StretchMode.zoomBackground],
  })  : assert(bannerHeight >= 0),
        super(
          key: key,
          title: title,
          titlePadding: titlePadding,
          background: banner,
          collapseMode: collapseMode,
          stretchModes: stretchModes,
        );

  @override
  State<FlexibleSpaceBar> createState() => _BannerFlexibleSpaceBarState();
}

class _BannerFlexibleSpaceBarState extends State<BannerFlexibleSpaceBar> {
  // apply to banner
  double _getBannerCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
    switch (widget.collapseMode) {
      case CollapseMode.pin:
        final double bottomExtent = settings.maxExtent - widget.bannerHeight;
        return settings.currentExtent - bottomExtent > settings.minExtent
            ? -(settings.maxExtent - settings.currentExtent)
            : -(widget.bannerHeight - settings.minExtent);
      case CollapseMode.none:
        return 0.0;
      case CollapseMode.parallax:
        final double deltaExtent = settings.maxExtent - settings.minExtent;
        return -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final FlexibleSpaceBarSettings settings =
            context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
        final List<Widget> children = <Widget>[];

        final double deltaExtent = settings.maxExtent - settings.minExtent;

        // 0.0 -> Expanded
        // 1.0 -> Collapsed to toolbar
        final double t = ((settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0);

        // background
        if (widget.background != null) {
          final double fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
          const double fadeEnd = 1.0;
          assert(fadeStart <= fadeEnd);
          // If the min and max extent are the same, the app bar cannot collapse
          // and the content should be visible, so opacity = 1.
          final double opacity =
              settings.maxExtent == settings.minExtent ? 1.0 : 1.0 - Interval(fadeStart, fadeEnd).transform(t);

          double height = settings.maxExtent;

          double bannerPadding = _getBannerCollapsePadding(t, settings);

          // StretchMode.zoomBackground
          if (widget.stretchModes.contains(StretchMode.zoomBackground) && constraints.maxHeight > height) {
            height = constraints.maxHeight;
          }

          // bottom the banner with linner layout
          children.add(Positioned(
            top: (widget.bannerHeight) + bannerPadding,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(child: widget.bottomExtentChild),
          ));

          // banner
          children.add(Positioned(
            top: bannerPadding,
            left: 0.0,
            right: 0.0,
            height: widget.bannerHeight,
            child: Container(
              child: widget.background,
            ),
          ));

          // banner transimition
          children.add(Positioned(
            top: bannerPadding,
            height: widget.bannerHeight,
            left: 0,
            right: 0,
            child: Opacity(
              // IOS is relying on this semantics node to correctly traverse
              // through the app bar when it is collapsed.
              alwaysIncludeSemantics: true,
              opacity: opacity,
              child: Container(
                color: const Color(0x55000000),
              ),
            ),
          ));

          // if (widget.children != null) children.addAll(widget.children!);

          // StretchMode.blurBackground
          if (widget.stretchModes.contains(StretchMode.blurBackground) && constraints.maxHeight > settings.maxExtent) {
            final double blurAmount = (constraints.maxHeight - settings.maxExtent) / 10;
            children.add(Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: blurAmount,
                  sigmaY: blurAmount,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ));
          }
        }

        return ClipRect(child: Stack(children: children));
      },
    );
  }
}
