import 'package:flutter/material.dart';

class BadgeWithRemoveIcon extends StatelessWidget {
  final Widget child;
  final Widget? icon;
  final Color? color;
  final Border? border;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapIcon;
  final EdgeInsets padding;
  final EdgeInsets iconPadding;
  final BorderRadius? borderRadius;

  const BadgeWithRemoveIcon({
    super.key,
    required this.child,
    this.icon,
    this.color,
    this.onTap,
    this.onTapIcon,
    this.padding = const EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
    this.iconPadding = const EdgeInsets.only(left: 2, right: 4),
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final colorScheme = Theme.of(context).colorScheme;
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: border ?? Border.all(width: 1, color: colorScheme.primary.withOpacity(0.5)),
            borderRadius: borderRadius,
          ),
          child: Row(
            children: [
              child,
              GestureDetector(
                onTap: onTapIcon,
                child: Padding(
                  padding: iconPadding,
                  child: icon ?? Icon(Icons.close_rounded, size: 16, color: color ?? colorScheme.primary),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
