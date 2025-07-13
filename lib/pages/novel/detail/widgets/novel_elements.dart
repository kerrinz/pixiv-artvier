import 'package:artvier/base/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 分页分隔线
class NovelPageDivider extends BasePage {
  const NovelPageDivider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: textTheme(context).bodyMedium?.color ?? Colors.grey))),
      ),
    );
  }
}

typedef NovelTextElement = List<TextSpan>;

/// 小说文本
class NovelText extends BasePage {
  const NovelText({
    super.key,
    required this.textSpanList,
    required this.textSize,
    this.onTap,
  });

  final List<TextSpan> textSpanList;

  final double textSize;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectableText.rich(
      TextSpan(children: textSpanList),
      style: textTheme(context).bodyLarge?.copyWith(fontSize: textSize),
      onTap: onTap,
    );
  }
}
