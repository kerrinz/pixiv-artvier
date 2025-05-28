import 'package:flutter/material.dart';

class MyBadge extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Border? border;
  final GestureTapCallback? onTap;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  const MyBadge({
    super.key,
    required this.child,
    this.color,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (onTap == null) {
        return Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.primary,
            border: border,
            borderRadius: borderRadius,
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        );
      }
      return Material(
        color: color ?? Theme.of(context).colorScheme.primary,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          splashFactory: InkSparkle.splashFactory,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              border: border,
            ),
            child: child,
          ),
        ),
      );
    });
  }
}
