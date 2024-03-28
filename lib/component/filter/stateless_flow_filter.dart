// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// [tapIndex] 点击事件触发的索引
typedef IndexTap = void Function(int tapIndex);

abstract class FlowFilterStatefulWidget extends StatelessWidget {
  FlowFilterStatefulWidget({
    super.key,
    this.initialIndexes = const {0},
    required this.itemCount,
    this.maxSelectedCount,
    required this.onTap,
    this.direction = Axis.horizontal,
    this.spacing = 0,
    this.runSpacing = 0,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
  })  : assert(maxSelectedCount == null || (0 < maxSelectedCount && maxSelectedCount <= itemCount)),
        assert(initialIndexes.every((int item) => 0 <= item && item < itemCount));

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

  final WrapAlignment alignment;

  final WrapAlignment runAlignment;

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
      alignment: alignment,
      runAlignment: runAlignment,
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
  final Border? selectedBorder;
  final Border? unselectedBorder;
  final EdgeInsets? textPadding;
  final BorderRadius? textBorderRadius;

  /// 注：优先级大于其他相关属性
  final BoxDecoration? selectedDecoration;

  /// 注：优先级大于其他相关属性
  final BoxDecoration? unselectedDecoration;

  StatelessTextFlowFilter({
    super.key,
    super.initialIndexes,
    required this.texts,
    required super.onTap,
    super.maxSelectedCount,
    super.direction,
    super.spacing = 4,
    super.runSpacing,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.selectedBackground,
    this.unselectedBackground,
    this.selectedBorder,
    this.unselectedBorder,
    this.textPadding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    this.textBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.selectedDecoration,
    this.unselectedDecoration,
    super.alignment,
    super.runAlignment,
  }) : super(
          itemCount: texts.length,
        );

  @override
  Widget buildSelectedWidget(BuildContext context, int index) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: textPadding,
      decoration: selectedDecoration ??
          BoxDecoration(
            color: selectedBackground ?? colorScheme.primary,
            border: selectedBorder,
            borderRadius: textBorderRadius,
          ),
      child: Text(
        texts[index],
        style: TextStyle(
          inherit: selectedTextStyle?.inherit ?? true,
          color: selectedTextStyle?.color ?? colorScheme.onPrimary,
          backgroundColor: selectedTextStyle?.backgroundColor,
          fontSize: selectedTextStyle?.fontSize ?? 14.0,
          fontWeight: selectedTextStyle?.fontWeight,
          fontStyle: selectedTextStyle?.fontStyle,
          letterSpacing: selectedTextStyle?.letterSpacing,
          wordSpacing: selectedTextStyle?.wordSpacing,
          textBaseline: selectedTextStyle?.textBaseline,
          height: selectedTextStyle?.height,
          leadingDistribution: selectedTextStyle?.leadingDistribution,
          locale: selectedTextStyle?.locale,
          foreground: selectedTextStyle?.foreground,
          background: selectedTextStyle?.background,
          shadows: selectedTextStyle?.shadows,
          fontFeatures: selectedTextStyle?.fontFeatures,
          fontVariations: selectedTextStyle?.fontVariations,
          decoration: selectedTextStyle?.decoration,
          decorationColor: selectedTextStyle?.decorationColor,
          decorationStyle: selectedTextStyle?.decorationStyle,
          decorationThickness: selectedTextStyle?.decorationThickness,
          debugLabel: selectedTextStyle?.debugLabel,
          fontFamily: selectedTextStyle?.fontFamily,
          fontFamilyFallback: selectedTextStyle?.fontFamilyFallback,
          overflow: selectedTextStyle?.overflow,
        ),
      ),
    );
  }

  @override
  Widget buildUnselectedWidget(BuildContext context, int index) {
    return Container(
      padding: textPadding,
      decoration: unselectedDecoration ??
          BoxDecoration(
            color: unselectedBackground,
            border: unselectedBorder,
            borderRadius: textBorderRadius,
          ),
      child: Text(
        texts[index],
        style: TextStyle(
          inherit: unselectedTextStyle?.inherit ?? true,
          color: unselectedTextStyle?.color ?? Theme.of(context).colorScheme.onSurface,
          backgroundColor: unselectedTextStyle?.backgroundColor,
          fontSize: unselectedTextStyle?.fontSize ?? 14.0,
          fontWeight: unselectedTextStyle?.fontWeight,
          fontStyle: unselectedTextStyle?.fontStyle,
          letterSpacing: unselectedTextStyle?.letterSpacing,
          wordSpacing: unselectedTextStyle?.wordSpacing,
          textBaseline: unselectedTextStyle?.textBaseline,
          height: unselectedTextStyle?.height,
          leadingDistribution: unselectedTextStyle?.leadingDistribution,
          locale: unselectedTextStyle?.locale,
          foreground: unselectedTextStyle?.foreground,
          background: unselectedTextStyle?.background,
          shadows: unselectedTextStyle?.shadows,
          fontFeatures: unselectedTextStyle?.fontFeatures,
          fontVariations: unselectedTextStyle?.fontVariations,
          decoration: unselectedTextStyle?.decoration,
          decorationColor: unselectedTextStyle?.decorationColor,
          decorationStyle: unselectedTextStyle?.decorationStyle,
          decorationThickness: unselectedTextStyle?.decorationThickness,
          debugLabel: unselectedTextStyle?.debugLabel,
          fontFamily: unselectedTextStyle?.fontFamily,
          fontFamilyFallback: unselectedTextStyle?.fontFamilyFallback,
          overflow: unselectedTextStyle?.overflow,
        ),
      ),
    );
  }
}
