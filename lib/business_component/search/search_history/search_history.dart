import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/search/search_history/provider.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/database/database.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
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
                IconButton(
                  onPressed: () {
                    ref.read(searchHistoryProvider.notifier).clearAll();
                  },
                  icon: SvgPicture.asset(
                    'assets/icon/trash_clear.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(textTheme.bodySmall?.color ?? Colors.grey, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...data.map((v) => SearchHistoryItem(data: v)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 搜索的输入框
class SearchHistoryItem extends BasePage {
  const SearchHistoryItem({
    super.key,
    required this.data,
  });

  final SearchHistoryTableData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: data.searchText);
      },
      child: MyBadge(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        color: colorScheme(context).surface,
        child: Text(
          data.searchText,
          style: textTheme(context).labelMedium,
        ),
      ),
    );
  }
}
