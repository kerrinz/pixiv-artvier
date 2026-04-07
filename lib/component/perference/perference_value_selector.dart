import 'package:flutter/material.dart';

/// 设置选项的数据结构
class PerferenceValueModel {
  final Widget? title;
  final Widget? description;

  const PerferenceValueModel({required this.title, required this.description});
}

/// 设置选项的选择器
class PerferenceValueSelector extends StatelessWidget {
  const PerferenceValueSelector({
    super.key,
    required this.values,
    this.activeIndex,
    this.onTap,
  });

  final void Function()? onTap;

  final List<PerferenceValueModel> values;

  /// 哪个选项已选
  final int? activeIndex;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var index = 0; index < values.length; index++) _buildItem(index, context),
    ]);
  }

  _buildItem(int index, context) {
    final value = values[index];
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (value.title != null) value.title!,
                    if (value.description != null) value.description!,
                  ],
                ),
              ),
              if (index == activeIndex)
                Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    Icon(
                      Icons.check,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                      size: 12,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
