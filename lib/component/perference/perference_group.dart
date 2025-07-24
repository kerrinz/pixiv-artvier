import 'package:flutter/material.dart';
import 'package:artvier/component/perference/perference_item.dart';

typedef ItemBuilder = Widget Function(int index);

/// 偏好设置组
///
/// 设置项无需设置圆角，本组件已进行处理
class PerferenceGroup extends StatelessWidget {
  const PerferenceGroup({
    super.key,
    required this.items,
    this.padding,
  });

  final List<PerferenceItem> items;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    int len = items.length;
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: len == 1
            // 单项
            ? items[0]
            // 多项
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int index = 0; index < len; index++) ..._itemBuilder(context, len, index),
                ],
              ),
      ),
    );
  }

  List<Widget> _itemBuilder(context, int length, int index) {
    if (index == 0) {
      return [items[index]];
    }
    return [
      _dividerWidget(context),
      items[index],
    ];
  }

  /// 分割线
  Widget _dividerWidget(context) {
    return SizedBox(
      width: double.infinity,
      height: 1,
      child: DecoratedBox(
          decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
      )),
    );
  }
}
