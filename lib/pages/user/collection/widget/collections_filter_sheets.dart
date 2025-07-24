import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/user/bookmark/bookmark_tag.dart';
import 'package:artvier/pages/user/collection/model/collections_filter_model.dart';
import 'package:artvier/pages/user/collection/provider/filter_provider.dart';
import 'package:artvier/pages/user/collection/provider/tags_provider.dart';
import 'package:artvier/pages/user/collection/widget/tag_listview.dart';

/// 我的收藏页面的筛选弹窗
class CollectionsFilterSheet extends ConsumerWidget {
  CollectionsFilterSheet({
    super.key,
  });

  /// 所有的 [Restrict] 选项
  final restrictOptions = [Restrict.public, Restrict.private];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetSlideBar(
            width: 48,
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          // 展示范围的选择
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text("显示范围: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              Consumer(builder: (_, ref, __) {
                Restrict restrict = ref.watch(cachedCollectionsFilterProvider.select((value) => value.restrict));

                return StatelessTextFlowFilter(
                  initialIndexes: {restrictOptions.indexOf(restrict)},
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Theme.of(context).colorScheme.primary.withAlpha(100)),
                  ),
                  unselectedDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Theme.of(context).colorScheme.background),
                  ),
                  selectedTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                  textPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  onTap: (int tapIndex) => ref
                      .read(cachedCollectionsFilterProvider.notifier)
                      .update((state) => state.copyWith(restrict: restrictOptions[tapIndex])),
                  texts: [
                    LocalizationIntl.of(context).public,
                    LocalizationIntl.of(context).private,
                  ],
                );
              }),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text("标签筛选", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          // 标签列表
          ScrollConfiguration(
            behavior: _CusBehavior(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.5,
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.surfaceContainerHighest),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Consumer(
                  builder: ((_, ref, __) {
                    var data = ref.watch(collectionsTagsProvider);
                    return TagListView(
                      tagList: [
                        // All
                        BookmarkTag(name: null),
                        // Uncategorized
                        BookmarkTag(name: ""),
                        if (data != null) ...data,
                      ],
                      onLazyload: () async {
                        return data == null
                            ? ref.watch(collectionsTagsProvider.notifier).fetch()
                            : ref.watch(collectionsTagsProvider.notifier).next();
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
          // 底部按钮
          SafeArea(
            child: Row(
              children: [
                // 取消按钮
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12, left: 0, right: 4),
                    child: CupertinoButton(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onPressed: () {
                        Navigator.of(context).pop<CollectionsFilterModel>(null);
                      },
                      child: Text(
                        LocalizationIntl.of(context).promptCancel,
                        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
                // 确定按钮
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12, left: 4, right: 0),
                    child: CupertinoButton(
                      color: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onPressed: () {
                        Navigator.of(context).pop<CollectionsFilterModel>(ref.read(cachedCollectionsFilterProvider));
                      },
                      child: Text(
                        LocalizationIntl.of(context).promptConform,
                        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 去除Android设备滚动到边界后的动画效果
class _CusBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    if (Platform.isAndroid || Platform.isFuchsia) return child;
    return super.buildOverscrollIndicator(context, child, details);
  }
}
