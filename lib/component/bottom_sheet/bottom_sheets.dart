import 'dart:async';

import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheets {
  static Future<T?> showCustomBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    Color? background,
    Color barrierColor = Colors.black54,
    borderRadius = const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
    enableDrag = true, // 拖拽退出
    exitOnClickModal = true, // 点击遮罩层退出
    bool useRootNavigator = false,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      elevation: 0,
      useRootNavigator: useRootNavigator,
      barrierColor: barrierColor, // 遮罩层颜色
      builder: (BuildContext context) {
        return Stack(
          children: [
            if (exitOnClickModal) GestureDetector(onTap: () => Navigator.of(context).pop()),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: background ?? Theme.of(context).colorScheme.surface,
                  borderRadius: borderRadius,
                ),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }

  /// 以 OverlayEntry 方式展示底部弹窗（可指定插入到某个 Entry 之上）。
  /// 用于下拉菜单等手动 Overlay 场景，避免被 ModalRoute 挡在下面。
  static Future<T?> showCustomBottomSheetOverlay<T>({
    required OverlayState overlayState,
    OverlayEntry? insertAbove,
    required Widget child,
    Color? background,
    Color barrierColor = Colors.black54,
    BorderRadiusGeometry borderRadius =
        const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
    bool enableDrag = true,
    bool exitOnClickModal = true,
    void Function(OverlayEntry entry, VoidCallback close)? onAttached,
  }) {
    final completer = Completer<T?>();
    late final OverlayEntry entry;
    var settled = false;

    void settle([T? result]) {
      if (settled) return;
      settled = true;
      if (entry.mounted) {
        entry.remove();
      }
      if (!completer.isCompleted) {
        completer.complete(result);
      }
    }

    entry = OverlayEntry(
      builder: (context) {
        return _OverlayAnimatedBottomSheet(
          barrierColor: barrierColor,
          barrierDismissible: exitOnClickModal,
          enableDrag: enableDrag,
          background: background,
          borderRadius: borderRadius,
          onCloseReady: (close) => onAttached?.call(entry, close),
          onClosed: settle,
          child: child,
        );
      },
    );

    if (insertAbove != null && insertAbove.mounted) {
      overlayState.insert(entry, above: insertAbove);
    } else {
      overlayState.insert(entry);
    }

    return completer.future;
  }

  // 列表选择菜单，返回选中的索引，无选择则返回-1
  static Future<int> showSelectItemsBottomSheet({
    required BuildContext context,
    required List<String> items,
    String? title,
    int selectedIndex = -1, // 选中哪一项
    barrierColor = Colors.black38,
    enableDrag = true,
    showCancel = false, // 是否显示取消按钮
    String? cancelText, // 取消按钮的文字
  }) async {
    int selected = -1;
    await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor, // 遮罩层颜色
      builder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(onTap: () => Navigator.of(context).pop()),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                ),
                child: SafeArea(
                  bottom: true,
                  minimum: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BottomSheetSlideBar(),
                        if (title != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(title, style: TextTheme.of(context).titleSmall),
                          ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Column(
                            children: [
                              for (var i = 0; i < items.length; i++)
                                InkWell(
                                  splashFactory: InkSparkle.splashFactory,
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  onTap: () {
                                    selected = i;
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.symmetric(vertical: 12, horizontal: 24),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(items[i]),
                                        ),
                                        Opacity(
                                          opacity: selectedIndex == i ? 1 : 0,
                                          child: Icon(Icons.check_rounded),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (showCancel)
                                Container(
                                  width: double.infinity,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  padding: const EdgeInsets.only(top: 8),
                                  child: SafeArea(
                                    bottom: true,
                                    child: CupertinoButton(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.zero,
                                      child: Text(
                                        cancelText ?? LocalizationIntl.of(context).promptCancel,
                                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return selected;
  }
}

/// Overlay 版底部弹窗：保留滑入动画与拖拽关闭（对标 [showModalBottomSheet]）。
class _OverlayAnimatedBottomSheet extends StatefulWidget {
  const _OverlayAnimatedBottomSheet({
    required this.child,
    required this.barrierColor,
    required this.barrierDismissible,
    required this.enableDrag,
    required this.background,
    required this.borderRadius,
    required this.onCloseReady,
    required this.onClosed,
  });

  final Widget child;
  final Color barrierColor;
  final bool barrierDismissible;
  final bool enableDrag;
  final Color? background;
  final BorderRadiusGeometry borderRadius;
  final ValueChanged<VoidCallback> onCloseReady;
  final VoidCallback onClosed;

  @override
  State<_OverlayAnimatedBottomSheet> createState() => _OverlayAnimatedBottomSheetState();
}

class _OverlayAnimatedBottomSheetState extends State<_OverlayAnimatedBottomSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  var _closing = false;
  var _closedNotified = false;

  @override
  void initState() {
    super.initState();
    _controller = BottomSheet.createAnimationController(this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _notifyClosed();
      }
    });
    widget.onCloseReady(close);
    _controller.forward();
  }

  void close() {
    if (_closing) return;
    _closing = true;
    _controller.reverse();
  }

  void _notifyClosed() {
    if (_closedNotified) return;
    _closedNotified = true;
    widget.onClosed();
  }

  @override
  void dispose() {
    _controller.dispose();
    // Entry 被强制移除时也要结束 Future
    _notifyClosed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    // 结构对齐 showCustomBottomSheet：BottomSheet 包住全屏 Stack，
    // 遮罩区域也是 sheet 的一部分，因而可在遮罩上拖拽带动主体下滑。
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final barrierAlpha = widget.barrierColor.a * _controller.value;
        return Stack(
          children: [
            // 固定在后方的视觉遮罩（随动画淡入淡出，不随 sheet 平移）
            Positioned.fill(
              child: ColoredBox(
                color: widget.barrierColor.withValues(alpha: barrierAlpha),
              ),
            ),
            FractionalTranslation(
              translation: Offset(0, 1 - curved.value),
              child: child,
            ),
          ],
        );
      },
      child: Material(
        type: MaterialType.transparency,
        child: BottomSheet(
          animationController: _controller,
          enableDrag: widget.enableDrag,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onClosing: close,
          builder: (context) {
            return SizedBox.expand(
              child: Stack(
                children: [
                  // 全屏透明层：点击关闭 + 拖拽关闭（命中测试不穿透）
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: widget.barrierDismissible ? close : null,
                    child: const ColoredBox(color: Colors.transparent),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Material(
                      color: widget.background ?? Theme.of(context).colorScheme.surface,
                      borderRadius: widget.borderRadius,
                      clipBehavior: Clip.antiAlias,
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}