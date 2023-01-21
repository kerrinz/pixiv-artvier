import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/pages/user/collection/model/collections_filter_model.dart';
import 'package:pixgem/pages/user/collection/provider/filter_provider.dart';
import 'package:pixgem/pages/user/collection/widget/collections_filter_sheets.dart';

mixin MyCollectionPageLogic {
  late final WidgetRef ref;

  /// 筛选按钮
  void handlePressedFilter() {
    BottomSheets.showCustomBottomSheet<CollectionsFilterModel>(
      context: ref.context,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      exitOnClickModal: false,
      child: CollectionsFilterSheet(),
    ).then((value) {
      if (value != null) ref.read(collectionsFilterProvider.notifier).update((state) => value);
    });
  }
}
