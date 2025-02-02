import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/main_navigation_tab_page/search/provider/search_input_provider.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [ExpandSearchPage] 的搜索框
class SearchInput extends BasePage {
  const SearchInput({
    this.textController,
    this.focusNode,
    super.key,
  });

  final TextEditingController? textController;

  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15), borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Row(
        children: [
          // 框左边的搜索图标
          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 4),
            child: Icon(Icons.search_outlined, size: 18),
          ),
          // 搜索框
          Expanded(
            flex: 1,
            child: TextField(
              autofocus: false,
              focusNode: focusNode,
              controller: textController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: "${l10n(context).search}...",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true, // 高度包裹，不会存在默认高度
              ),
              onSubmitted: (value) {
                // 跳转搜索结果页面
                Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: value);
              },
              onChanged: (value) => ref.read(searchInputProvider.notifier).update((state) => value),
            ),
          ),
          // 清空按钮
          Consumer(
            builder: (_, ref, __) {
              String text = ref.watch(searchInputProvider);
              if (text.isEmpty) {
                return Container();
              }
              return InkWell(
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.clear, size: 18),
                ),
                onTap: () {
                  textController?.clear();
                  ref.read(searchInputProvider.notifier).update((state) => "");
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
