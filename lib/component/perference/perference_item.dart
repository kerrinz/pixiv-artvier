import 'package:flutter/material.dart';

/// 偏好设置项
///
/// 建议搭配偏好设置组[PerferenceGroup]一起使用，即使只有一个设置项
class PerferenceItem extends StatelessWidget {
  const PerferenceItem({
    super.key,
    this.icon,
    required this.text,
    this.value,
    this.onTap,
    this.borderRadius = BorderRadius.zero,
  });

  final Widget? icon;

  final Widget text;

  final Widget? value;

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
              icon == null
                  ? text
                  : Row(
                      children: [
                        icon!,
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: text,
                        ),
                      ],
                    ),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    value ??
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                          size: 12,
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
