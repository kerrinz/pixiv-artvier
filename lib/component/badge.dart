import 'package:flutter/material.dart';

class MyBadge extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Border? border;
  final GestureTapCallback? onTap;
  final EdgeInsets? padding;

  const MyBadge({
    super.key,
    required this.child,
    this.color,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    this.border,
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
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        );
      }
      return Material(
        color: color ?? Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
