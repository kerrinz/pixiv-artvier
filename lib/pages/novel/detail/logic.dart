import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin NovelDetailPageLogic {
  WidgetRef get ref;

  /// 作品详细信息
  late CommonNovel? novelDetail;

  /// 作品ID
  late String novelId;

  late ScrollController scrollController;

  /// 滚动到第几分页，0是回到首页（顶部）
  scrollToPage(BuildContext context, List<NovelElementModel> elements, GlobalKey bodyKey, bool animate, int page) {
    if (page <= 1) {
      animate
          ? scrollController.animateTo(
              0,
              duration: Durations.extralong1,
              curve: Curves.fastEaseInToSlowEaseOut,
            )
          : scrollController.jumpTo(0);
      return;
    }

    final pageDividers = elements.where((element) => element.type == NovelElementType.pageDivider);
    // page:index => 1:-1, 1:0, 2:1
    final findIndex = page - 2;
    if (findIndex >= pageDividers.length) {
      return;
    }
    final findElement = pageDividers.elementAt(findIndex);
    final key = findElement.key;
    if (key == null) {
      return;
    }
    RenderBox targetBox = pageDividers.elementAt(page - 2).key!.currentContext!.findRenderObject() as RenderBox;
    RenderBox bodyBox = bodyKey.currentContext!.findRenderObject() as RenderBox;

    Offset targetPosition = targetBox.localToGlobal(Offset.zero);
    Offset bodyPosition = bodyBox.localToGlobal(Offset.zero);

    // 减去分页器自身高度
    double clipOffset = findElement.type == NovelElementType.pageDivider ? targetBox.size.height : 0;

    double relative = (targetPosition - bodyPosition).dy +
        scrollController.offset -
        kToolbarHeight -
        MediaQuery.paddingOf(context).top +
        clipOffset;
    animate
        ? scrollController.animateTo(
            relative,
            duration: Durations.extralong1,
            curve: Curves.fastEaseInToSlowEaseOut,
          )
        : scrollController.jumpTo(relative);
  }

  /// 滚动到第几章节
  scrollToChapter(
      BuildContext context, List<NovelElementModel> elements, GlobalKey bodyKey, bool animate, int chapter) {
    if (chapter <= 0) {
      animate
          ? scrollController.animateTo(
              0,
              duration: Durations.extralong1,
              curve: Curves.fastEaseInToSlowEaseOut,
            )
          : scrollController.jumpTo(0);
      return;
    }

    final chapterTitles = elements.where((element) => element.type == NovelElementType.chapterTitle);
    // page:index => 1:-1, 1:0, 2:1
    final findIndex = chapter - 1;
    if (findIndex >= chapterTitles.length) {
      return;
    }
    final findElement = chapterTitles.elementAt(findIndex);
    final key = findElement.key;
    if (key == null) {
      return;
    }
    RenderBox targetBox = chapterTitles.elementAt(findIndex).key!.currentContext!.findRenderObject() as RenderBox;
    RenderBox bodyBox = bodyKey.currentContext!.findRenderObject() as RenderBox;

    Offset targetPosition = targetBox.localToGlobal(Offset.zero);
    Offset bodyPosition = bodyBox.localToGlobal(Offset.zero);

    // 减去分页器自身高度
    double clipOffset = findElement.type == NovelElementType.pageDivider ? targetBox.size.height : 0;

    double relative = (targetPosition - bodyPosition).dy +
        scrollController.offset -
        kToolbarHeight -
        MediaQuery.paddingOf(context).top +
        clipOffset;
    animate
        ? scrollController.animateTo(
            relative,
            duration: Durations.extralong1,
            curve: Curves.fastEaseInToSlowEaseOut,
          )
        : scrollController.jumpTo(relative);
  }
}

/// 小说详情/阅读器，弹出遮罩层的动画
mixin NovelDetailOverlaySettingsAnimation<T extends StatefulWidget>
    implements State<T>, SingleTickerProviderStateMixin<T> {
  late AnimationController overlayAnimationController;
  late Animation<Offset> overlayOffsetAnimation;
  final Tween<Offset> overlayOffsetTween = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero);
  static const Duration kFadeOutDuration = Duration(milliseconds: 300);
  static const Duration kFadeInDuration = Duration(milliseconds: 300);
  bool overlayShow = false;

  void initOverlaySettingsState() {
    overlayAnimationController = AnimationController(
      duration: kFadeInDuration,
      value: 0.0,
      vsync: this,
    );
    overlayOffsetAnimation =
        overlayAnimationController.drive(CurveTween(curve: Curves.linear)).drive(overlayOffsetTween);
    overlayOffsetTween.end = Offset.zero;
  }

  void animateOverlay() {
    if (overlayAnimationController.isAnimating) return;
    final bool wasHeldDown = overlayShow;
    final TickerFuture ticker = overlayShow
        ? overlayAnimationController.animateTo(1.0, duration: kFadeOutDuration, curve: Curves.linearToEaseOut)
        : overlayAnimationController.animateTo(0.0, duration: kFadeInDuration, curve: Curves.easeOutCubic);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != overlayShow) animateOverlay();
    });
  }
}
