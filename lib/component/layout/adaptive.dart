import 'dart:math' as math;
import 'dart:ui' show FlutterView;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 平板与手机的布局分界。手机短边低于此值，布局保持原样。
const double kTabletShortestSide = 600;

/// 横屏窗口宽到这个值才启用左右分栏。
const double kTabletSplitMinWidth = 900;

bool isTabletWindow(BuildContext context) {
  return MediaQuery.sizeOf(context).shortestSide >= kTabletShortestSide;
}

/// 平板横屏：左侧列表，右侧详情。
bool useTabletSplitView(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  return size.shortestSide >= kTabletShortestSide &&
      size.width >= kTabletSplitMinWidth &&
      size.width > size.height;
}

/// 插画/漫画瀑布流列数。窄屏沿用 [compact]（手机默认 2）。
int illustColumnCount(double width, {int compact = 2}) {
  if (width < 500) return compact;
  if (width < 800) return math.max(compact, 3);
  if (width < 1100) return math.max(compact, 4);
  if (width < 1400) return math.max(compact, 5);
  return math.max(compact, 6);
}

/// 小说、用户等横向卡片。窄屏沿用 [compact]（通常为 1）。
int wideListColumnCount(double width, {int compact = 1}) {
  if (width < 680) return compact;
  if (width < 1100) return math.max(compact, 2);
  return math.max(compact, 3);
}

/// 趋势标签。窄屏沿用 [compact]（默认 3）。
int tagColumnCount(double width, {int compact = 3}) {
  if (width < 500) return compact;
  if (width < 800) return math.max(compact, 4);
  if (width < 1100) return math.max(compact, 6);
  return math.max(compact, 8);
}

/// 首页轮播。手机保持原来的高度和每页宽度。
class HomeCarouselLayout {
  const HomeCarouselLayout({
    required this.imageHeight,
    required this.viewportFraction,
    required this.slotExtent,
  });

  final double imageHeight;
  final double viewportFraction;

  /// 轮播区域在工具栏之下的高度。
  final double slotExtent;
}

HomeCarouselLayout homeCarouselLayout(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  if (size.shortestSide >= kTabletShortestSide && size.height > size.width) {
    return const HomeCarouselLayout(
      imageHeight: 160,
      viewportFraction: 0.76,
      slotExtent: 220,
    );
  }
  return const HomeCarouselLayout(
    imageHeight: 100,
    viewportFraction: 0.86,
    slotExtent: 160,
  );
}

/// 首页横向排行榜卡片边长。手机仍是短边 / 2.5。
double rankingCardExtent(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final raw = math.min(size.width, size.height) / 2.5;
  if (size.shortestSide < kTabletShortestSide) return raw;
  return math.min(raw, 196);
}

/// 把分栏里的 [MediaQuery.size] 改成这一栏的尺寸，并避开底部手势条。
class AdaptivePane extends StatelessWidget {
  const AdaptivePane({
    super.key,
    required this.child,
    this.safeLeft = false,
    this.safeRight = false,
  });

  final Widget child;
  final bool safeLeft;
  final bool safeRight;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final bottom = media.padding.bottom;
        final height = math.max(0.0, constraints.maxHeight - bottom);
        return Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: MediaQuery(
            data: media.copyWith(
              size: Size(constraints.maxWidth, height),
              padding: media.padding.copyWith(
                left: safeLeft ? media.padding.left : 0,
                right: safeRight ? media.padding.right : 0,
                bottom: 0,
              ),
              viewPadding: media.viewPadding.copyWith(
                left: safeLeft ? media.viewPadding.left : 0,
                right: safeRight ? media.viewPadding.right : 0,
                bottom: 0,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}

/// 手机锁定竖屏；平板允许旋转。看大图时临时放开，退出后恢复。
class DeviceOrientationPolicy {
  static bool _tabletDevice = false;
  static bool _viewerOpen = false;

  static void applyForView(FlutterView view) {
    final logical = view.display.size / view.display.devicePixelRatio;
    final shortest = math.min(logical.width, logical.height);
    if (shortest <= 0) return;
    _tabletDevice = shortest >= kTabletShortestSide;
    if (!_viewerOpen) {
      _apply();
    }
  }

  static void allowAll() {
    _viewerOpen = true;
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  static void restore() {
    _viewerOpen = false;
    _apply();
  }

  static void _apply() {
    if (_tabletDevice) {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      return;
    }
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
