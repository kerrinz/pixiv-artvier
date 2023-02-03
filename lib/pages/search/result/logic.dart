import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';
import 'package:artvier/pages/search/result/provider/search_filters_provider.dart';
import 'package:artvier/pages/search/result/arguments/seach_filter_arguments.dart';
import 'package:artvier/pages/search/result/provider/search_result_provider.dart';
import 'package:artvier/pages/search/result/search_result_page.dart';
import 'package:artvier/pages/search/result/widget/seach_filter_bottom_sheet.dart';

mixin SearchResultPageLogic on State<SearchResultPage> {
  WidgetRef get ref;

  /// 搜索框输入的关键词
  late String searchWord = widget.label;

  /// 搜索插画+漫画
  late final searchArtworksProvider = AutoDisposeAsyncNotifierProvider<SearchArtworksNotifier, List<CommonIllust>>(
    () => SearchArtworksNotifier(searchWord: searchWord),
  );

  /// 搜索小说
  late final searchNovelsProvider = AutoDisposeAsyncNotifierProvider<SearchNovelsNotifier, List<CommonNovel>>(
      () => SearchNovelsNotifier(searchWord: searchWord));

  /// 搜索用户
  late final searchUsersProvider = AutoDisposeAsyncNotifierProvider<SearchUsersNotifier, List<CommonUserPreviews>>(
      () => SearchUsersNotifier(searchWord: searchWord));

  /// 使用新参数进行搜索
  void _doSearch(String searchWord) {
    SearchType searchType = ref.read(searchTypeProvider);
    Map doMap = <SearchType, void Function()>{
      SearchType.artwork: () => ref.read(searchArtworksProvider.notifier).search(searchWord),
      SearchType.novel: () => ref.read(searchNovelsProvider.notifier).search(searchWord),
      SearchType.user: () => ref.read(searchUsersProvider.notifier).search(searchWord),
    };
    doMap[searchType]();
  }

  /// 搜索输入框的提交
  void handleInputSubmit(String value) {
    searchWord = value;
    _doSearch(value);
  }

  /// 筛选按钮
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
      // _doReload();
    });
  }

  /// 点击切换搜索类型
  void handleTapSearchType(SearchType searchType) {
    ref.read(searchTypeProvider.notifier).update((state) => searchType);
  }
}
