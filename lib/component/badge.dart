import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final Color? color;
  final GestureTapCallback? onTap;

  const Badge({Key? key, required this.child, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (onTap == null) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.primary,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: child,
          ),
          splashColor: Theme.of(context).colorScheme.primaryContainer, // 长按渐渐覆盖区域的颜色
          highlightColor: Colors.transparent,
        ),
      );
    });
  }
}
