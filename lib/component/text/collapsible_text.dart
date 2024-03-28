import 'package:flutter/material.dart';
import 'package:artvier/l10n/localization_intl.dart';

/// 可收起、展开的文字组件，用于展开更多文本
class CollapsibleText extends StatefulWidget {
  final String text;

  final TextStyle? style;

  final TextAlign textAlign;

  final TextDirection textDirection;

  final TextOverflow? overflow;

  /// 折叠后显示的最大行数
  final int? collapsedMaxLine;

  /// 初始是否折叠
  final bool isCollapsedInitially;

  /// 是否可被选择，可选择时使用 [Selectable] 代替 [Text]
  final bool isSelectable;

  /// 自定义折叠按钮
  final Widget? collapseButton;

  /// 自定义展开按钮
  final Widget? expandButton;

  /// 按钮的排列方式
  final MainAxisAlignment buttonAxisAlignment;

  const CollapsibleText({
    super.key,
    required this.text,
    this.style = const TextStyle(fontSize: 12),
    this.textAlign = TextAlign.start,
    this.textDirection = TextDirection.ltr,
    this.overflow,
    this.collapsedMaxLine,
    this.isCollapsedInitially = false,
    this.isSelectable = false,
    this.collapseButton,
    this.expandButton,
    this.buttonAxisAlignment = MainAxisAlignment.end,
  })  : assert(collapsedMaxLine == null || collapsedMaxLine > 0),
        assert(!isCollapsedInitially || collapsedMaxLine != null,
            "Initially collapsed must ensure that collapsedMaxLine is not null.");

  @override
  State<StatefulWidget> createState() => _CollapsibleTextState();
}

class _CollapsibleTextState extends State<CollapsibleText> {
  late bool _isCollapsed;

  @override
  void initState() {
    super.initState();
    _isCollapsed = widget.isCollapsedInitially;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final textPainter = TextPainter(
        text: TextSpan(text: widget.text, style: widget.style),
        maxLines: widget.collapsedMaxLine,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
      );
      textPainter.layout(maxWidth: constraints.maxWidth);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isSelectable
              ? SelectableText(
                  widget.text,
                  style: widget.style,
                  maxLines: textPainter.didExceedMaxLines && _isCollapsed // 超出并且处于已折叠状态
                      ? widget.collapsedMaxLine
                      : null, // 不超出时设为null避免占空行
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  strutStyle: const StrutStyle(forceStrutHeight: true),
                )
              : Text(
                  widget.text,
                  style: widget.style,
                  maxLines: widget.collapsedMaxLine,
                ),
          if (textPainter.didExceedMaxLines)
            Row(
              mainAxisAlignment: widget.buttonAxisAlignment,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: _isCollapsed
                        ? widget.expandButton ??
                            Text(LocalizationIntl.of(context).textExpand,
                                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary))
                        : widget.collapseButton ??
                            Text(LocalizationIntl.of(context).textCollapse,
                                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary)),
                  ),
                ),
              ],
            ),
        ],
      );
    });
  }
}
