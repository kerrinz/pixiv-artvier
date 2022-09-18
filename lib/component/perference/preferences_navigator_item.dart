import 'package:flutter/material.dart';

class PreferencesNavigatorItem extends StatelessWidget {
  final Widget text;
  final Widget? icon;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const PreferencesNavigatorItem({Key? key, required this.text, this.icon, this.onTap, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? Container(),
            Expanded(
              flex: 1,
              child: text,
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).colorScheme.outline,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
