import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/pages/search/result/provider/search_filters_provider.dart';
import 'package:pixgem/pages/search/result/arguments/seach_filter_arguments.dart';
import 'package:pixgem/pages/search/result/provider/search_result_provider.dart';
import 'package:pixgem/pages/search/result/widget/seach_filter_bottom_sheet.dart';

mixin SearchResultPageLogic {
  late final WidgetRef ref;

  /// 重新加载数据
  void _doReload() {
    SearchType searchType = ref.read(searchTypeProvider);
    Map doMap = <SearchType, void Function()>{
      SearchType.artwork: () => ref.read(searchArtworksProvider.notifier).reload(),
      SearchType.novel: () => ref.read(searchArtworksProvider.notifier).reload(),
      SearchType.user: () => ref.read(searchArtworksProvider.notifier).reload(),
    };
    doMap[searchType]();
  }

  /// 搜索输入框的提交
  void handleInputSubmit() {
    _doReload();
  }

  /// 确定筛选
  void handlePressedFilter() {
    var type = ref.read(searchTypeProvider);
    if (type == SearchType.user) return;

    // 筛选弹窗
    BottomSheets.showCustomBottomSheet<SearchFilterArguments?>(
      context: ref.context,
      child: const SearchFilterBottomSheet(),
    ).then((args) {
      if (args == null) return;
      ref.read(searchFilterProvider.notifier).update((state) => args);
      _doReload();
    });
  }

  /// 点击切换搜索类型
  void handleTapSearchType(SearchType searchType) {
    ref.read(searchTypeProvider.notifier).update((state) => searchType);
  }
}
