import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetSelectItem extends StatelessWidget {
  final Widget text;
  final void Function() onTap;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  const BottomSheetSelectItem({
    Key? key,
    this.padding,
    this.alignment = Alignment.center,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.zero,
      child: CupertinoButton(
        pressedOpacity: 0.5,
        padding: padding ?? EdgeInsets.zero,
        color: Theme.of(context).cardColor,
        alignment: alignment,
        borderRadius: BorderRadius.zero,
        child: DefaultTextStyle(
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
          child: text,
        ),
        onPressed: onTap,
      ),
    );
  }
}
