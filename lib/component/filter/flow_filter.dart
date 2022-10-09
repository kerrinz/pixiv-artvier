// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// [isChanged] 是否发生变化（类似Web中的onChange事件的升级版），[tapIndex] 点击事件触发的索引，[afterIndexes] 事件触发执行完毕后当前已选择项的索引列表
typedef IndexesChanged = void Function(bool isChanged, int tapIndex, Set<int> afterIndexes);

/// 过滤方式
enum FilterMode {
  /// 单选，至少至多选择一项
  single,

  /// 多选，可以全不选，至多选择 [maxSelectedCount] 项
  multiple,
}

abstract class FlowFilterWidget extends StatefulWidget {
  FlowFilterWidget({
    Key? key,
    this.initialIndexes = const {0},
    required this.itemCount,
    this.maxSelectedCount,
    required this.onTap,
    this.filterMode = FilterMode.single,
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
  final IndexesChanged onTap;

  final FilterMode filterMode;

  final Axis direction;

  /// 主轴方向子widget的间距
  final double spacing;

  /// 纵轴方向的间距
  final double runSpacing;

  Widget buildSelectedWidget(BuildContext context, int index);
  Widget buildUnselectedWidget(BuildContext context, int index);

  @override
  State<StatefulWidget> createState() => _FlowFilterWidgetState();
}

class _FlowFilterWidgetState extends State<FlowFilterWidget> {
  final Set<int> _selectedindexes = {};

  @override
  void initState() {
    super.initState();
    _selectedindexes.addAll(widget.initialIndexes);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.itemCount; i++) {
      if (_selectedindexes.contains(i)) {
        widgets.add(GestureDetector(
          onTap: () {
            bool isChanged = false;
            if (widget.filterMode == FilterMode.multiple) {
              _selectedindexes.remove(i);
              isChanged = true;
              setState(() {});
            }
            widget.onTap(isChanged, i, _selectedindexes);
          },
          child: widget.buildSelectedWidget(context, i),
        ));
      } else {
        widgets.add(GestureDetector(
          onTap: () {
            bool isChanged = false;
            switch (widget.filterMode) {
              case FilterMode.single:
                _selectedindexes.clear();
                _selectedindexes.add(i);
                isChanged = true;
                setState(() {});
                break;
              case FilterMode.multiple:
                if (widget.maxSelectedCount == null || _selectedindexes.length > widget.maxSelectedCount!) {
                  _selectedindexes.add(i);
                  isChanged = true;
                  setState(() {});
                }
            }
            widget.onTap(isChanged, i, _selectedindexes);
          },
          child: widget.buildUnselectedWidget(context, i),
        ));
      }
    }
    return Wrap(
      direction: widget.direction,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: widgets,
    );
  }
}

/// 需要自定义内容和样式的过滤器组件，所有待选项均同时显示；支持流式布局
class CustomFlowFilter extends FlowFilterWidget {
  CustomFlowFilter({
    Key? key,
    Set<int> initialIndexes = const {0},
    required this.selectedWidgets,
    required this.unselectedWidgets,
    required IndexesChanged onTap,
    FilterMode filterMode = FilterMode.single,
    int? maxSelectedCount,
    Axis direction = Axis.horizontal,
    double spacing = 0,
    double runSpacing = 0,
  })  : assert(selectedWidgets.length == unselectedWidgets.length),
        assert(unselectedWidgets.isNotEmpty),
        super(
          key: key,
          initialIndexes: initialIndexes,
          itemCount: unselectedWidgets.length,
          maxSelectedCount: maxSelectedCount,
          filterMode: filterMode,
          onTap: onTap,
          direction: direction,
          spacing: spacing,
          runSpacing: runSpacing,
        );

  final List<Widget> selectedWidgets;
  final List<Widget> unselectedWidgets;

  @override
  buildSelectedWidget(BuildContext context, int index) {
    return selectedWidgets[index];
  }

  @override
  buildUnselectedWidget(BuildContext context, int index) {
    return unselectedWidgets[index];
  }
}

/// 文字形过滤器组件
class TextFlowFilter extends FlowFilterWidget {
  /// 所有项的文字
  final List<String> texts;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final Color? selectedBackground;
  final Color? unselectedBackground;
  final EdgeInsets? textPadding;
  final Border? textBorder;
  final BorderRadius? textBorderRadius;

  TextFlowFilter({
    Key? key,
    Set<int> initialIndexes = const {0},
    required this.texts,
    required IndexesChanged onTap,
    int? maxSelectedCount,
    FilterMode filterMode = FilterMode.single,
    Axis direction = Axis.horizontal,
    double spacing = 2,
    double runSpacing = 0,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.selectedBackground,
    this.unselectedBackground,
    this.textPadding = const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
    this.textBorder,
    this.textBorderRadius = const BorderRadius.all(Radius.circular(4)),
  }) : super(
          key: key,
          initialIndexes: initialIndexes,
          itemCount: texts.length,
          filterMode: filterMode,
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
