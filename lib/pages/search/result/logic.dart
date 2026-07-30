import 'package:artvier/business_component/search/search_history/provider.dart';
import 'package:artvier/component/filter_dropdown/filter_dropdown_list.dart';
import 'package:artvier/component/form/date_select.dart';
import 'package:artvier/database/database.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';
import 'package:artvier/pages/search/result/provider/search_filters_provider.dart';
import 'package:artvier/pages/search/result/provider/search_result_provider.dart';
import 'package:artvier/pages/search/result/search_result_page.dart';

mixin SearchResultPageLogic on State<SearchResultPage> {
  WidgetRef get ref;
  DropDownMenuController get dropDownMenuController;

  /// 搜索框输入的关键词
  late String searchWord = widget.label;

  /// 搜索插画+漫画
  late final searchArtworksProvider = AsyncNotifierProvider<SearchArtworksNotifier, List<CommonIllust>>(
    () => SearchArtworksNotifier(searchWord: searchWord),
  );

  /// 搜索小说
  late final searchNovelsProvider = AsyncNotifierProvider<SearchNovelsNotifier, List<CommonNovel>>(
      () => SearchNovelsNotifier(searchWord: searchWord));

  /// 搜索用户
  late final searchUsersProvider = AsyncNotifierProvider<SearchUsersNotifier, List<CommonUserPreviews>>(
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
    // 添加搜索历史记录
    ref.read(searchHistoryProvider.notifier).addSearchHistory(SearchHistoryTableData(
          searchText: widget.label,
          type: ref.read(searchTypeProvider),
          lastTime: DateTime.now(),
        ));
    searchWord = value;
    _doSearch(value);
  }

  /// 点击切换搜索类型
  void handleTapSearchType(SearchType searchType) {
    if (dropDownMenuController.isExpanded()) {
      dropDownMenuController.closeMenu();
    } else {
      ref.read(searchTypeProvider.notifier).update((state) => searchType);
    }
  }

  void handleChangeMenu(int index, String? value) {
    if (value != null) {
      switch (index) {
        case 0:
          ref.read(searchFilterProvider.notifier).update((state) => state.copyWith(sort: value));
          break;
        case 1:
          ref.read(searchFilterProvider.notifier).update((state) => state.copyWith(match: value));
          break;
        case 2:
          ref.read(searchFilterProvider.notifier).update((state) => state.copyWith(searchAiType: int.parse(value)));
          break;
        case 3:
          setFilterDate(value);
          break;
        case 4:
          ref.read(searchFilterProvider.notifier).update((state) => state.copyWith(bookmarkCountNotPremium: value));
          break;
      }
    }
    _reloadSearchResult();
  }

  void _reloadSearchResult() {
    final currentWorkType = ref.read(searchTypeProvider.notifier).state;
    if (SearchType.artwork == currentWorkType) {
      ref.read(searchArtworksProvider.notifier).reload();
    } else if (SearchType.novel == currentWorkType) {
      ref.read(searchNovelsProvider.notifier).reload();
    } else {
      ref.read(searchUsersProvider.notifier).reload();
    }
  }

  /// 点击「指定日期」：不选中菜单项，弹出日期范围 BottomSheet
  Future<void> handleTapCustomPeriod(BuildContext context, int menuIndex) async {
    final filter = ref.read(searchFilterProvider);
    DateTime? initialStart;
    DateTime? initialEnd;
    if (filter.startDate != null && filter.startDate!.isNotEmpty) {
      initialStart = DateTime.tryParse(filter.startDate!);
    }
    if (filter.endDate != null && filter.endDate!.isNotEmpty) {
      initialEnd = DateTime.tryParse(filter.endDate!);
    }

    final result = await DatePickerSheets.showDateRange(
      context,
      initialStart: initialStart,
      initialEnd: initialEnd,
    );
    if (result == null || !mounted) return;

    final start = DatePickerSheets.formatDateValue(result.start);
    final end = DatePickerSheets.formatDateValue(result.end);
    dropDownMenuController.selectMenuValue(menuIndex, 'custom');
    setCustomFilterDate(startDate: start, endDate: end);
    _reloadSearchResult();
  }

  void setCustomFilterDate({
    required String startDate,
    required String endDate,
  }) {
    ref.read(searchFilterProvider.notifier).update(
          (state) => state.copyWith(startDate: startDate, endDate: endDate),
        );
  }

  void setFilterDate(String value) {
    switch (value) {
      case '24h':
        final endDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
        ref
            .read(searchFilterProvider.notifier)
            .update((state) => state.copyWith(startDate: endDate, endDate: endDate));
        break;
      case '1week':
        final endDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
        final startDate = formatDate(DateTime.now().subtract(const Duration(days: 7)), [yyyy, '-', mm, '-', dd]);
        ref
            .read(searchFilterProvider.notifier)
            .update((state) => state.copyWith(startDate: startDate, endDate: endDate));
        break;
      case '1month':
        final endDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
        final startDate = formatDate(DateTime.now().subtract(const Duration(days: 30)), [yyyy, '-', mm, '-', dd]);
        ref
            .read(searchFilterProvider.notifier)
            .update((state) => state.copyWith(startDate: startDate, endDate: endDate));
        break;
      case 'halfYear':
        final endDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
        final startDate = formatDate(DateTime.now().subtract(const Duration(days: 183)), [yyyy, '-', mm, '-', dd]);
        ref
            .read(searchFilterProvider.notifier)
            .update((state) => state.copyWith(startDate: startDate, endDate: endDate));
        break;
      case '1year':
        final endDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
        final startDate = formatDate(DateTime.now().subtract(const Duration(days: 365)), [yyyy, '-', mm, '-', dd]);
        ref
            .read(searchFilterProvider.notifier)
            .update((state) => state.copyWith(startDate: startDate, endDate: endDate));
        break;
      // 'all'
      default:
        ref.read(searchFilterProvider.notifier).update((state) => state.copyWith(startDate: '', endDate: ''));
        break;
    }
  }
}
