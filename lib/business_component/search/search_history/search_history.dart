import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/search/search_history/provider.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/expanded/expandable_wrap.dart';
import 'package:artvier/database/database.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

/// 搜索历史记录
class SearchHistory extends BaseStatefulPage {
  const SearchHistory({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends BasePageState {
  ValueNotifier<bool> isEditMode = ValueNotifier(false);
  final tags = List.generate(20, (i) => '标签$i');

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(searchHistoryProvider).valueOrNull;
    if (data == null || data.isEmpty) return SizedBox();
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    l10n.searchHistory,
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isEditMode,
                  builder: (_, isEditModeValue, __) {
                    return isEditModeValue
                        ? editModeContent()
                        : IconButton(
                            onPressed: () => isEditMode.value = !isEditMode.value,
                            icon: SvgPicture.asset(
                              'assets/icon/trash_clear.svg',
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(textTheme.bodySmall?.color ?? Colors.grey, BlendMode.srcIn),
                            ),
                          );
                  },
                ),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isEditMode,
              builder: (_, isEditModeValue, __) {
                // return Wrap(
                //   spacing: 8,
                //   runSpacing: 8,
                //   children: [
                //     ...data.map(
                //       (v) => SearchHistoryItem(
                //         data: v,
                //         isEditMode: isEditModeValue,
                //         onTap: () {
                //           if (isEditModeValue) {
                //             ref.read(searchHistoryProvider.notifier).removeOneSearchHistory(v.searchText);
                //           } else {
                //             Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: v.searchText);
                //           }
                //         },
                //         onLongPress: () => isEditMode.value = !isEditMode.value,
                //       ),
                //     ),
                //   ],
                // );
                return ExpandableWrap(
                  maxLines: 2,
                  spacing: 8,
                  runSpacing: 8,
                  animationDuration: Duration.zero,
                  expandButtonBuilder: (expanded) => MyBadge(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                    color: colorScheme.surface,
                    child: Icon(
                      expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      size: (textTheme.labelMedium?.fontSize ?? 12) + 4,
                    ),
                  ),
                  children: data
                      .map(
                        (v) => SearchHistoryItem(
                          data: v,
                          isEditMode: isEditModeValue,
                          onTap: () {
                            if (isEditModeValue) {
                              ref.read(searchHistoryProvider.notifier).removeOneSearchHistory(v.searchText);
                            } else {
                              Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: v.searchText);
                            }
                          },
                          onLongPress: () {
                            HapticFeedback.lightImpact();
                            isEditMode.value = !isEditMode.value;
                          },
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 编辑模式下的按钮
  Widget editModeContent() {
    return Row(
      spacing: 4,
      children: [
        IconButton(
            onPressed: () async {
              bool isCancel = true; // 用户是否取消
              await showDialog(
                context: ref.context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(l10n.promptTitle),
                    content: Text(l10n.clearSearchHistoryPromptContent),
                    actions: <Widget>[
                      TextButton(child: Text(l10n.promptCancel), onPressed: () => Navigator.pop(context)),
                      TextButton(
                        child: Text(l10n.promptConform),
                        onPressed: () {
                          isCancel = false;
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
              if (isCancel) return;
              ref.read(searchHistoryProvider.notifier).clearAll();
            },
            icon: Text(l10n.clearAll, style: textTheme.labelMedium)),
        Container(
          width: 1,
          height: textTheme.labelMedium?.fontSize ?? 16,
          color: colorScheme.outlineVariant,
        ),
        IconButton(
            onPressed: () => isEditMode.value = !isEditMode.value,
            icon: Text(l10n.complete, style: textTheme.labelMedium?.copyWith(color: colorScheme.primary)))
      ],
    );
  }
}

/// 搜索的输入框
class SearchHistoryItem extends BasePage {
  const SearchHistoryItem({
    super.key,
    required this.data,
    this.isEditMode = false,
    this.onTap,
    this.onLongPress,
  });

  final SearchHistoryTableData data;
  final bool isEditMode;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: MyBadge(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        color: colorScheme(context).surface,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.searchText,
              style: textTheme(context).labelMedium,
            ),
            if (isEditMode)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(Icons.close, size: (textTheme(context).labelMedium?.fontSize ?? 12) + 2),
              ),
          ],
        ),
      ),
    );
  }
}
