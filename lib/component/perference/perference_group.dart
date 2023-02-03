import 'package:flutter/material.dart';
import 'package:artvier/component/perference/perference_item.dart';

typedef ItemBuilder = Widget Function(int index);

/// 偏好设置组
///
/// 设置项无需设置圆角，本组件已进行处理
class PerferenceGroup extends StatelessWidget {
  const PerferenceGroup({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<PerferenceItem> items;

  @override
  Widget build(BuildContext context) {
    int len = items.length;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: len == 1
          // 单项
          ? items[0]
          // 多项
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < len; index++) ..._itemBuilder(len, index),
              ],
            ),
    );
  }

  List<Widget> _itemBuilder(int length, int index) {
    if (index == 0) {
      return [items[index]];
    }
    return [
      _dividerWidget(),
      items[index],
    ];
  }

  /// 分割线
  Widget _dividerWidget() {
    return SizedBox(
      width: double.infinity,
      height: 1,
      child: DecoratedBox(
          decoration: BoxDecoration(
        color: Colors.grey[300],
      )),
    );
  }
}
