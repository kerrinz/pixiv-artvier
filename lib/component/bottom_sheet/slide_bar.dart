import 'package:flutter/material.dart';

///
/// Dialog的顶部小横条
///

class BottomSheetSlideBar extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;
  final double width;
  final double height;
  final Color? color;
  final BorderRadiusGeometry borderRadius;

  const BottomSheetSlideBar({
    Key? key,
    this.width = 32.0,
    this.height = 4.0,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
    this.color,
    this.alignment = Alignment.center,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: padding,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.outline,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
