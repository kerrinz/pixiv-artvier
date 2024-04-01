import 'package:artvier/base/base_page.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 搜索的输入框
class SearchInput extends BasePage {
  const SearchInput({
    super.key,
    this.textColor,
    this.backgroundColor,
  });

  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.withOpacity(0.15),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(
        children: [
          // 搜索图标
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 4),
            child: Icon(
              Icons.search_outlined,
              size: 18,
              color: textColor ?? textTheme(context).bodyMedium?.color ?? Colors.black,
            ),
          ),
          // 文本区域
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                // 展开搜索框
                Navigator.of(context).pushNamed(RouteNames.expandSearch.name);
              },
              child: Text(
                "${i10n(context).search}...",
                style: textColor != null
                    ? textTheme(context).bodyMedium?.copyWith(color: textColor)
                    : textTheme(context).bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
