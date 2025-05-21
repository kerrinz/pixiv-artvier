import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin NovelDetailPageLogic {
  WidgetRef get ref;

  /// 作品详细信息
  late CommonNovel? novelDetail;

  /// 作品ID
  late String worksId;
}

/// 小说详情/阅读器，弹出遮罩层的动画
mixin NovelDetailOverlaySettingsAnimation<T extends StatefulWidget>
    implements State<T>, SingleTickerProviderStateMixin<T> {
  late AnimationController overlayAnimationController;
  late Animation<Offset> overlayOffsetAnimation;
  final Tween<Offset> overlayOffsetTween = Tween<Offset>(begin: const Offset(0, 100), end: Offset.zero);
  static const Duration kFadeOutDuration = Duration(milliseconds: 500);
  static const Duration kFadeInDuration = Duration(milliseconds: 500);
  bool overlayShow = false;

  void initOverlaySettingsState() {
    overlayAnimationController = AnimationController(
      duration: const Duration(microseconds: 200),
      value: 0.0,
      vsync: this,
    );
    overlayOffsetAnimation =
        overlayAnimationController.drive(CurveTween(curve: Curves.decelerate)).drive(overlayOffsetTween);
    overlayOffsetTween.end = Offset.zero;
  }

  void animateOverlay() {
    if (overlayAnimationController.isAnimating) return;
    final bool wasHeldDown = overlayShow;
    final TickerFuture ticker = overlayShow
        ? overlayAnimationController.animateTo(1.0, duration: kFadeOutDuration, curve: Curves.easeInOutCubicEmphasized)
        : overlayAnimationController.animateTo(0.0, duration: kFadeInDuration, curve: Curves.easeOutCubic);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != overlayShow) animateOverlay();
    });
  }
}
