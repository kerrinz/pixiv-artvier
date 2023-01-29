import 'package:flutter/material.dart';

/// 偏好设置项
///
/// 建议搭配偏好设置组[PerferenceGroupWidget]一起使用，即使只有一个设置项
class PerferenceItem extends StatelessWidget {
  const PerferenceItem({
    Key? key,
    required this.leftWidget,
    required this.rightWidget,
    this.onTap,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  final Widget leftWidget;

  final Widget rightWidget;

  final void Function()? onTap;

  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: leftWidget,
              ),
              rightWidget,
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
