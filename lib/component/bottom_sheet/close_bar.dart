import 'package:flutter/material.dart';

///
/// 底部弹窗的包含关闭按钮的顶栏
///
class BottomSheetCloseBar extends StatelessWidget {
  final Widget? title;

  final void Function()? onTapClose;

  final EdgeInsetsGeometry padding;

  const BottomSheetCloseBar({
    super.key,
    this.title,
    this.onTapClose,
    this.padding = const EdgeInsets.all(12.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: title ?? const Align(),
          ),
          BottomSheetCloseButton(onTap: onTapClose),
        ],
      ),
    );
  }
}

/// 底部弹窗的关闭按钮
class BottomSheetCloseButton extends StatelessWidget {
  final void Function()? onTap;

  const BottomSheetCloseButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(Icons.close_rounded, size: 16),
        ),
      ),
    );
  }
}
