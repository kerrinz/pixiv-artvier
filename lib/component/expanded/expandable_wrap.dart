import 'package:flutter/material.dart';

/// 可展开的 Wrap，展开按钮参与布局计算
class ExpandableWrap extends StatefulWidget {
  final List<Widget> children;
  final int maxLines;
  final double spacing;
  final double runSpacing;
  final TextStyle? buttonTextStyle;
  final Duration animationDuration;
  final Widget Function(bool expanded) expandButtonBuilder;

  const ExpandableWrap({
    super.key,
    required this.children,
    required this.expandButtonBuilder,
    this.maxLines = 2,
    this.spacing = 8,
    this.runSpacing = 8,
    this.buttonTextStyle,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<ExpandableWrap> createState() => _ExpandableWrapState();
}

class _ExpandableWrapState extends State<ExpandableWrap> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final calc = _calculateVisibleCount(maxWidth);

      final visibleCount = calc.visibleCount;
      final needsButton = calc.needsButton;

      final childrenToShow = <Widget>[
        ...widget.children.take(visibleCount),
        if (needsButton) _buildButton(_expanded),
      ];

      return AnimatedSize(
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: widget.spacing,
          runSpacing: widget.runSpacing,
          children: childrenToShow,
        ),
      );
    });
  }

  /// 计算可见数量 + 是否需要按钮
  _CalcResult _calculateVisibleCount(double maxWidth) {
    if (widget.children.isEmpty) return _CalcResult(0, false);

    final itemWidths = _estimateChildWidths(context, widget.children);
    final buttonWidth = _estimateChildWidths(context, [_buildButton(true)]).first;

    // 判断所有元素是否能放下（不含按钮）
    final allChildrenFit = _canAllFit(
      itemWidths: itemWidths,
      maxWidth: maxWidth,
      maxLines: widget.maxLines,
    );

    if (allChildrenFit) {
      // 所有元素都能放下 -> 不显示按钮
      return _CalcResult(widget.children.length, false);
    }

    // 判断所有元素 + 按钮是否能放下
    final allChildrenPlusButtonFit = _canAllFit(
      itemWidths: [...itemWidths, buttonWidth],
      maxWidth: maxWidth,
      maxLines: widget.maxLines,
    );

    if (allChildrenPlusButtonFit) {
      // 按钮也能放下 -> 仍然显示全部，但按钮可显示（用于收起）
      return _CalcResult(widget.children.length, true);
    }

    // 折叠模式下计算可见元素数量（保证按钮在最后一行内）
    if (!_expanded) {
      double lineWidth = 0;
      int currentLine = 1;
      int visibleCount = 0;

      for (int i = 0; i < itemWidths.length; i++) {
        final itemWidth = itemWidths[i];
        if (lineWidth + itemWidth > maxWidth) {
          currentLine++;
          lineWidth = 0;
        }

        // 如果加上按钮会超过 maxLines，就停
        final nextWidth = lineWidth + itemWidth + widget.spacing + buttonWidth;
        if (currentLine == widget.maxLines && nextWidth > maxWidth) break;
        if (currentLine > widget.maxLines) break;

        lineWidth += itemWidth + widget.spacing;
        visibleCount++;
      }

      return _CalcResult(visibleCount, true);
    }

    // 展开状态显示全部 + 按钮
    return _CalcResult(widget.children.length, true);
  }

  /// 判断所有元素能否放进 maxLines 行
  bool _canAllFit({
    required List<double> itemWidths,
    required double maxWidth,
    required int maxLines,
  }) {
    double lineWidth = 0;
    int lineCount = 1;

    for (final width in itemWidths) {
      if (lineWidth + width > maxWidth) {
        lineCount++;
        lineWidth = 0;
      }
      lineWidth += width + widget.spacing;

      if (lineCount > maxLines) return false;
    }

    return lineCount <= maxLines;
  }

  List<double> _estimateChildWidths(BuildContext context, List<Widget> children) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final List<double> widths = [];

    for (final child in children) {
      if (child is Chip && child.label is Text) {
        final text = (child.label as Text).data ?? '';
        textPainter.text = TextSpan(text: text, style: child.labelStyle);
        textPainter.layout();
        widths.add(textPainter.width + 32);
      } else {
        widths.add(80 * textScale);
      }
    }
    return widths;
  }

  Widget _buildButton(bool expanded) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: widget.expandButtonBuilder(expanded),
    );
  }
}

class _CalcResult {
  final int visibleCount;
  final bool needsButton;

  _CalcResult(this.visibleCount, this.needsButton);
}
