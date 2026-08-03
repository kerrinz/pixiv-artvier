import 'dart:async';

import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/advanced_collecting_bottom_sheet.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/model/advanced_collecting_data.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/database/database.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_element.dart';
import 'package:artvier/pages/novel/detail/detail_page.dart';
import 'package:artvier/pages/novel/detail/provider/novel_detail_provider.dart';
import 'package:artvier/util/novel_viewer_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin NovelDetailPageLogic on BasePageState<NovelDetailPage> {
  /// 作品ID
  late String novelId;

  late ScrollController scrollController;

  /// 阅读进度保存防抖
  Timer? readingProgressSaveTimer;

  /// 小说详情页的收藏状态
  /// 可能有多个插画详情页同时存在于页面栈中，因此使用.family为不同插画id做区分
  late final novelDetailCollectStateProvider = StateNotifierProvider.autoDispose<CollectNotifier, CollectState>((ref) {
    // 监听全局美术作品收藏状态通知器的变化
    ref.listen<CollectStateChangedArguments?>(globalNovelCollectionStateChangedProvider, (previous, next) {
      if (next != null && next.worksId == novelId) {
        ref.notifier.setCollectState(next.state);
      }
    });
    var detail = ref.watch(novelDetailProvider(novelId)).value?.novel;
    final state = detail?.isBookmarked ?? widget.args.detail?.isBookmarked;
    return CollectNotifier(
      (state == null
          ? CollectState.loading
          : state
              ? CollectState.collected
              : CollectState.notCollect),
      ref: ref,
      worksId: novelId,
      worksType: WorksType.novel,
    );
  });

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

  /// 阅读线（状态栏 + AppBar 下方）的全局 Y
  double _readingLineY(BuildContext context) =>
      MediaQuery.paddingOf(context).top + kToolbarHeight;

  /// 元素顶部对应的滚动 offset
  double? _scrollOffsetForElement(
    BuildContext context,
    NovelElementModel element,
    GlobalKey bodyKey,
  ) {
    final targetContext = element.key?.currentContext;
    final bodyContext = bodyKey.currentContext;
    if (targetContext == null || bodyContext == null) return null;
    final targetBox = targetContext.findRenderObject() as RenderBox?;
    final bodyBox = bodyContext.findRenderObject() as RenderBox?;
    if (targetBox == null || bodyBox == null || !targetBox.hasSize) return null;

    final targetPosition = targetBox.localToGlobal(Offset.zero);
    final bodyPosition = bodyBox.localToGlobal(Offset.zero);
    final clipOffset = element.type == NovelElementType.pageDivider ? targetBox.size.height : 0.0;

    return (targetPosition - bodyPosition).dy +
        scrollController.offset -
        kToolbarHeight -
        MediaQuery.paddingOf(context).top +
        clipOffset;
  }

  TextPainter _paragraphTextPainter({
    required List<TextSpan> spans,
    required TextStyle? style,
    required double maxWidth,
  }) {
    return TextPainter(
      text: TextSpan(children: spans, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
  }

  /// 将字符偏移映射为元素内第几行（spans 按行拆分）
  int _lineIndexForUtfOffset(List<TextSpan> spans, int utfOffset) {
    var consumed = 0;
    for (var i = 0; i < spans.length; i++) {
      consumed += spans[i].text?.length ?? 0;
      if (utfOffset < consumed) return i;
    }
    return spans.isEmpty ? 0 : spans.length - 1;
  }

  /// 元素内第 [lineInBlock] 行相对元素顶部的偏移
  double _lineOffsetWithinElement({
    required BuildContext context,
    required NovelElementModel element,
    required int lineInBlock,
    required double textSize,
    String? fontFamily,
    Color? foreground,
  }) {
    if (lineInBlock <= 0 || element.type != NovelElementType.text) return 0;
    final targetContext = element.key?.currentContext;
    if (targetContext == null) return 0;
    final box = targetContext.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize || box.size.width <= 0) return 0;

    final spans = element.element as List<TextSpan>;
    if (lineInBlock >= spans.length) return 0;

    var charOffset = 0;
    for (var j = 0; j < lineInBlock; j++) {
      charOffset += spans[j].text?.length ?? 0;
    }

    final style = novelViewerFontTextStyle(
          fontFamily: fontFamily,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          fontSize: textSize,
          color: foreground,
        );
    final painter = _paragraphTextPainter(spans: spans, style: style, maxWidth: box.size.width);
    return painter.getOffsetForCaret(TextPosition(offset: charOffset), Rect.zero).dy;
  }

  /// 根据当前滚动位置计算页码（与书签逻辑一致，从 1 起）
  int resolveCurrentPage(
    BuildContext context,
    List<NovelElementModel> elements,
    GlobalKey bodyKey,
  ) {
    int page = 1;
    for (var element in elements) {
      if (element.type != NovelElementType.pageDivider) continue;
      final key = element.key;
      final targetContext = key?.currentContext;
      final bodyContext = bodyKey.currentContext;
      if (key == null || targetContext == null || bodyContext == null) {
        logger.w('resolveCurrentPage find a null key/context of NovelElementType.pageDivider.');
        break;
      }
      final targetBox = targetContext.findRenderObject() as RenderBox?;
      final bodyBox = bodyContext.findRenderObject() as RenderBox?;
      if (targetBox == null || bodyBox == null) break;

      final targetPosition = targetBox.localToGlobal(Offset.zero);
      final bodyPosition = bodyBox.localToGlobal(Offset.zero);
      final relative = (targetPosition - bodyPosition).dy - MediaQuery.paddingOf(context).top;
      final screenHeight = MediaQuery.sizeOf(context).height;

      if (relative < screenHeight) {
        page++;
      } else {
        break;
      }
    }
    return page;
  }

  /// 当前浏览到的段落序号；仍在封面/信息区时返回 -1
  int resolveCurrentParagraphIndex(
    BuildContext context,
    List<NovelElementModel> elements,
    List<({int start, int end})?> paragraphRanges,
    GlobalKey bodyKey, {
    required double textSize,
    String? fontFamily,
    Color? foreground,
  }) {
    final readingY = _readingLineY(context);
    var result = -1;

    for (var i = 0; i < elements.length; i++) {
      final range = i < paragraphRanges.length ? paragraphRanges[i] : null;
      if (range == null) continue;

      final element = elements[i];
      final targetContext = element.key?.currentContext;
      if (targetContext == null) continue;
      final box = targetContext.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;

      final top = box.localToGlobal(Offset.zero).dy;
      final bottom = top + box.size.height;

      if (bottom <= readingY) {
        result = range.end - 1;
        continue;
      }
      if (top > readingY) break;

      // 阅读线落在该元素内部
      if (element.type != NovelElementType.text || range.end - range.start <= 1) {
        result = range.start;
        break;
      }

      final spans = element.element as List<TextSpan>;
      final style = novelViewerFontTextStyle(
            fontFamily: fontFamily,
            textStyle: Theme.of(context).textTheme.bodyLarge,
            fontSize: textSize,
            color: foreground,
          );
      final painter = _paragraphTextPainter(spans: spans, style: style, maxWidth: box.size.width);
      final localY = (readingY - top).clamp(0.0, box.size.height);
      final pos = painter.getPositionForOffset(Offset(0, localY));
      final lineInBlock = _lineIndexForUtfOffset(spans, pos.offset);
      result = (range.start + lineInBlock).clamp(range.start, range.end - 1);
      break;
    }
    return result;
  }

  /// 滚动到指定段落（按布局实时计算，横竖屏/改字号均可）
  void scrollToParagraph(
    BuildContext context,
    List<NovelElementModel> elements,
    List<({int start, int end})?> paragraphRanges,
    GlobalKey bodyKey,
    int paragraphIndex, {
    required double textSize,
    String? fontFamily,
    Color? foreground,
    bool animate = false,
  }) {
    if (!scrollController.hasClients) return;
    if (paragraphIndex < 0) {
      animate
          ? scrollController.animateTo(0, duration: Durations.extralong1, curve: Curves.fastEaseInToSlowEaseOut)
          : scrollController.jumpTo(0);
      return;
    }

    for (var i = 0; i < elements.length; i++) {
      final range = i < paragraphRanges.length ? paragraphRanges[i] : null;
      if (range == null) continue;
      if (paragraphIndex < range.start || paragraphIndex >= range.end) continue;

      final element = elements[i];
      final baseOffset = _scrollOffsetForElement(context, element, bodyKey);
      if (baseOffset == null) return;

      final lineInBlock = paragraphIndex - range.start;
      final lineOffset = _lineOffsetWithinElement(
        context: context,
        element: element,
        lineInBlock: lineInBlock,
        textSize: textSize,
        fontFamily: fontFamily,
        foreground: foreground,
      );
      final target = (baseOffset + lineOffset).clamp(0.0, scrollController.position.maxScrollExtent);
      animate
          ? scrollController.animateTo(target, duration: Durations.extralong1, curve: Curves.fastEaseInToSlowEaseOut)
          : scrollController.jumpTo(target);
      return;
    }
  }

  /// 书签按钮点击事件
  handleMarkerClick(
    BuildContext context,
    List<NovelElementModel> elements,
    GlobalKey bodyKey,
    void Function(int) callback,
  ) {
    callback(resolveCurrentPage(context, elements, bodyKey));
  }

  /// 防抖保存阅读进度
  void scheduleSaveReadingProgress(
    BuildContext context,
    List<NovelElementModel> elements,
    List<({int start, int end})?> paragraphRanges,
    GlobalKey bodyKey, {
    required double textSize,
    String? fontFamily,
    Color? foreground,
  }) {
    readingProgressSaveTimer?.cancel();
    readingProgressSaveTimer = Timer(const Duration(milliseconds: 400), () {
      if (!context.mounted) return;
      saveReadingProgress(
        context,
        elements,
        paragraphRanges,
        bodyKey,
        textSize: textSize,
        fontFamily: fontFamily,
        foreground: foreground,
      );
    });
  }

  /// 立刻保存当前阅读进度（仍在封面区时不覆盖已有进度）
  void saveReadingProgress(
    BuildContext context,
    List<NovelElementModel> elements,
    List<({int start, int end})?> paragraphRanges,
    GlobalKey bodyKey, {
    required double textSize,
    String? fontFamily,
    Color? foreground,
  }) {
    if (!scrollController.hasClients || !context.mounted) return;
    final paragraphIndex = elements.isEmpty
        ? -1
        : resolveCurrentParagraphIndex(
            context,
            elements,
            paragraphRanges,
            bodyKey,
            textSize: textSize,
            fontFamily: fontFamily,
            foreground: foreground,
          );
    // 还在封面/信息区，保留上次正文进度
    if (paragraphIndex < 0) return;

    final page = resolveCurrentPage(context, elements, bodyKey);
    appDatabase.saveNovelReadingProgress(
      novelId: novelId,
      paragraphIndex: paragraphIndex,
      page: page,
    );
  }

  /// 恢复到上次阅读段落
  void restoreReadingProgress(
    BuildContext context,
    List<NovelElementModel> elements,
    List<({int start, int end})?> paragraphRanges,
    GlobalKey bodyKey,
    NovelReadingProgressTableData progress, {
    required double textSize,
    String? fontFamily,
    Color? foreground,
    int retry = 0,
  }) {
    if (!mounted || !scrollController.hasClients) return;

    final maxExtent = scrollController.position.maxScrollExtent;
    final needsLayout = maxExtent <= 0 && (progress.paragraphIndex >= 0 || progress.page > 1);
    if (needsLayout && retry < 8) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        restoreReadingProgress(
          context,
          elements,
          paragraphRanges,
          bodyKey,
          progress,
          textSize: textSize,
          fontFamily: fontFamily,
          foreground: foreground,
          retry: retry + 1,
        );
      });
      return;
    }

    if (progress.paragraphIndex >= 0 && paragraphRanges.isNotEmpty) {
      scrollToParagraph(
        context,
        elements,
        paragraphRanges,
        bodyKey,
        progress.paragraphIndex,
        textSize: textSize,
        fontFamily: fontFamily,
        foreground: foreground,
      );
      return;
    }

    if (progress.page > 1) {
      scrollToPage(context, elements, bodyKey, false, progress.page);
    }
  }

  /// 点击收藏按钮的事件
  void handleTapCollect(WidgetRef ref) {
    HapticFeedback.lightImpact();
    var l10n = LocalizationIntl.of(ref.context);
    CollectState status = ref.read(novelDetailCollectStateProvider);
    var notifier = ref.read(novelDetailCollectStateProvider.notifier);
    if (status == CollectState.notCollect) {
      // 当前未收藏，添加收藏
      notifier
          .collect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? l10n.addCollectSucceed : l10n.addCollectFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${l10n.addCollectFailed}, (Maybe already collected)", toastLength: Toast.LENGTH_LONG));
    }
    if (status == CollectState.collected) {
      // 当前已收藏，移除收藏
      notifier
          .uncollect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? l10n.removeCollectionSucceed : l10n.removeCollectionFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${l10n.removeCollectionFailed}, (Maybe already un-collected)", toastLength: Toast.LENGTH_LONG));
    }
  }

  // 长按收藏按钮的事件
  void handleLongTapCollect(WidgetRef ref) {
    HapticFeedback.lightImpact();
    var l10n = LocalizationIntl.of(ref.context);
    CollectState status = ref.read(novelDetailCollectStateProvider);
    if ([CollectState.collecting, CollectState.uncollecting].contains(status)) {
      return;
    }
    // // 高级收藏弹窗
    BottomSheets.showCustomBottomSheet<AdvancedCollectingDataModel>(
      context: ref.context,
      exitOnClickModal: false,
      enableDrag: false,
      child: AdvancedCollectingBottomSheet(
        isCollected: status == CollectState.collected ? true : false,
        worksId: novelId,
        worksType: WorksType.novel,
      ),
    ).then((value) {
      if (value != null) {
        ref
            .read(novelDetailCollectStateProvider.notifier)
            .collect(args: value)
            .then((result) => Fluttertoast.showToast(
                msg: result ? l10n.addCollectSucceed : l10n.addCollectFailed, toastLength: Toast.LENGTH_LONG))
            .catchError((_) => Fluttertoast.showToast(
                msg: "${l10n.addCollectFailed}, (Maybe already collected)", toastLength: Toast.LENGTH_LONG));
      }
    });
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
