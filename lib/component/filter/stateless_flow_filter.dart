// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// [tapIndex] 点击事件触发的索引
typedef IndexTap = void Function(int tapIndex);

abstract class FlowFilterStatefulWidget extends StatelessWidget {
  FlowFilterStatefulWidget({
    Key? key,
    this.initialIndexes = const {0},
    required this.itemCount,
    this.maxSelectedCount,
    required this.onTap,
    this.direction = Axis.horizontal,
    this.spacing = 0,
    this.runSpacing = 0,
  })  : assert(maxSelectedCount == null || (0 < maxSelectedCount && maxSelectedCount <= itemCount)),
        assert(initialIndexes.every((int item) => 0 <= item && item < itemCount)),
        super(key: key);

  /// 初始化时被选择的索引，范围：[0 ~ unselectedWidgets.length]
  final Set<int> initialIndexes;

  /// 可选项的总数量
  final int itemCount;

  /// 最多选择多少项，为null时仅受 [itemCount] 限制
  final int? maxSelectedCount;

  /// 点击事件的回调，value范围：[0 ~ unselectedWidgets.length]
  final IndexTap onTap;

  final Axis direction;

  /// 主轴方向子widget的间距
  final double spacing;

  /// 纵轴方向的间距
  final double runSpacing;

  Widget buildSelectedWidget(BuildContext context, int index);
  Widget buildUnselectedWidget(BuildContext context, int index);
  
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < itemCount; i++) {
      if (initialIndexes.contains(i)) {
        widgets.add(GestureDetector(
          onTap: () => onTap(i),
          child: buildSelectedWidget(context, i),
        ));
      } else {
        widgets.add(GestureDetector(
          onTap: () => onTap(i),
          child: buildUnselectedWidget(context, i),
        ));
      }
    }
    return Wrap(
      direction: direction,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      spacing: spacing,
      runSpacing: runSpacing,
      children: widgets,
    );
  }
}

/// 文字形过滤器组件
class StatelessTextFlowFilter extends FlowFilterStatefulWidget {
  /// 所有项的文字
  final List<String> texts;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final Color? selectedBackground;
  final Color? unselectedBackground;
  final EdgeInsets? textPadding;
  final Border? textBorder;
  final BorderRadius? textBorderRadius;

  StatelessTextFlowFilter({
    Key? key,
    Set<int> initialIndexes = const {0},
    required this.texts,
    required IndexTap onTap,
    int? maxSelectedCount,
    Axis direction = Axis.horizontal,
    double spacing = 2,
    double runSpacing = 0,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.selectedBackground,
    this.unselectedBackground,
    this.textPadding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    this.textBorder,
    this.textBorderRadius = const BorderRadius.all(Radius.circular(4)),
  }) : super(
          key: key,
          initialIndexes: initialIndexes,
          itemCount: texts.length,
          onTap: onTap,
          maxSelectedCount: maxSelectedCount,
          direction: direction,
          spacing: spacing,
          runSpacing: runSpacing,
        );

  @override
  Widget buildSelectedWidget(BuildContext context, int index) {
    return Container(
      padding: textPadding,
      decoration: BoxDecoration(
        color: selectedBackground ?? Theme.of(context).colorScheme.primary,
        border: textBorder,
        borderRadius: textBorderRadius,
      ),
      child: Text(texts[index], style: selectedTextStyle ?? TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
    );
  }

  @override
  Widget buildUnselectedWidget(BuildContext context, int index) {
    return Container(
      padding: textPadding,
      decoration: BoxDecoration(
        color: unselectedBackground,
        border: textBorder,
        borderRadius: textBorderRadius,
      ),
      child: Text(texts[index], style: unselectedTextStyle),
    );
  }
}
