import 'dart:io';

import 'package:artvier/api_app/api_serach.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/filter_dropdown/filter_dropdown_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/business_component/listview/novel_listview/novel_list.dart';
import 'package:artvier/business_component/listview/user_vertical_listview/user_vertical_listview.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/pages/search/result/logic.dart';
import 'package:artvier/pages/search/result/provider/search_filters_provider.dart';

class SearchResultPage extends ConsumerStatefulWidget {
  final String label; // 搜索文本内容

  const SearchResultPage(Object arguments, {super.key}) : label = arguments as String;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchResultPageState();
}

class SearchResultPageState extends ConsumerState<SearchResultPage> with WidgetsBindingObserver, SearchResultPageLogic {
  late TextEditingController _textController;

  @override
  late final DropDownMenuController dropDownMenuController;

  late final FocusNode _focusNode;

  /// 键盘是否激活状态
  bool isKeyboardActived = false;

  /// 所有的搜索类型
  final List<SearchType> _searchTypes = [SearchType.artwork, SearchType.novel, SearchType.user];

  LocalizationIntl get l10n => LocalizationIntl.of(context);

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  final layerlink = LayerLink();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.label);
    dropDownMenuController = DropDownMenuController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // 失去焦点时标记
        isKeyboardActived = false;
      }
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // 页面高度变化（键盘收起或弹出）时
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Platform.isAndroid && _focusNode.hasFocus) {
        if (isKeyboardActived) {
          // 使输入框失去焦点
          // _focusNode.unfocus();
        }
        isKeyboardActived = !isKeyboardActived;
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _textController.dispose();
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarLeadingButtton(),
        titleSpacing: 0,
        title: Container(
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.15), borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          child: TextField(
            controller: _textController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            autofocus: false,
            focusNode: _focusNode,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: "${l10n.search}...",
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isCollapsed: true, // 高度包裹，不会存在默认高度
            ),
            // onChanged: (value) => ref.read(searchResultInputProvider.notifier).update((state) => value),
            // 提交搜索
            onSubmitted: (value) => handleInputSubmit(value),
          ),
        ),
        actions: const [
          SizedBox(width: 24),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverWidgetPersistentHeaderDelegate(
              maxHeight: 50,
              minHeight: 50,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: colorScheme.surface,
                child: Consumer(builder: (_, ref, __) {
                  // 当前搜索类型
                  SearchType currentSearchType = ref.watch(searchTypeProvider);
                  // 当前搜索类型相对于全部搜索类型的索引
                  int index = _searchTypes.indexOf(currentSearchType);
                  ref.watch(searchFilterProvider);

                  // 搜索类型的切换组件
                  return StatelessTextFlowFilter(
                    initialIndexes: {index >= 0 ? index : 0},
                    alignment: WrapAlignment.spaceAround,
                    selectedDecoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    selectedBackground: Theme.of(context).colorScheme.secondary,
                    unselectedBackground: Theme.of(context).colorScheme.surface,
                    selectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
                    unselectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                    textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    textBorderRadius: const BorderRadius.all(Radius.circular(20)),
                    spacing: 8,
                    texts: [
                      "${l10n.illust} • ${l10n.manga}",
                      l10n.novels,
                      l10n.users,
                    ],
                    onTap: (int tapIndex) => handleTapSearchType(_searchTypes[tapIndex]),
                  );
                }),
              ),
            ),
          ),

          Consumer(builder: ((context, ref, child) {
            final searchType = ref.watch(searchTypeProvider);
            final widget = CompositedTransformTarget(
              link: layerlink,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: DropDownMenu(
                    controller: dropDownMenuController,
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    layerLink: layerlink,
                    onChange: handleChangeMenu,
                    filterList: [
                      DropDownMenuModel(
                        name: 'sort',
                        defaultValue: ApiSearchConstants.dateDesc,
                        list: [
                          CategoryModel(value: ApiSearchConstants.dateDesc, name: l10n.sortDateDesc, check: false),
                          CategoryModel(value: ApiSearchConstants.dateAsc, name: l10n.sortDateAsc, check: false),
                        ],
                      ),
                      DropDownMenuModel(
                        name: 'match',
                        defaultValue: ApiSearchConstants.tagPartialMatch,
                        list: [
                          CategoryModel(
                              value: ApiSearchConstants.tagPartialMatch, name: l10n.tagPartialMatch, check: false),
                          CategoryModel(
                              value: ApiSearchConstants.tagPerfectMatch, name: l10n.tagPerfectMatch, check: false),
                          CategoryModel(
                              value: ApiSearchConstants.titleAndDescription,
                              name: l10n.titleOrDescriptionMatch,
                              check: false),
                        ],
                      ),
                      DropDownMenuModel(
                        name: 'AI',
                        defaultValue: '0',
                        list: [
                          CategoryModel(value: '0', name: l10n.showAiResult, check: false),
                          CategoryModel(value: '1', name: l10n.hideAiResult, check: false),
                        ],
                      ),
                      // Period 时间段
                      DropDownMenuModel(
                        name: l10n.period,
                        // defaultValue: '0',
                        list: [
                          CategoryModel(value: 'all', name: l10n.allPeriod, check: false),
                          CategoryModel(value: '24h', name: l10n.searchTwentyFourHour, check: false),
                          CategoryModel(value: '1week', name: l10n.searchOneWeek, check: false),
                          CategoryModel(value: '1month', name: l10n.searchOneMonth, check: false),
                          CategoryModel(value: 'halfYear', name: l10n.searchHalfYear, check: false),
                          CategoryModel(value: '1year', name: l10n.searchOneYear, check: false),
                          // CategoryModel(value: 'custom', name: l10n.selectPeriod, check: false),
                        ],
                      ),
                      // 收藏数（非会员功能）
                      DropDownMenuModel(
                        name: l10n.bookmarkCountNotPremium,
                        list: [
                          CategoryModel(value: 'all', name: '不限制', check: false),
                          CategoryModel(value: '30000users入り', name: '30000users入り', check: false),
                          CategoryModel(value: '20000users入り', name: '20000users入り', check: false),
                          CategoryModel(value: '10000users入り', name: '10000users入り', check: false),
                          CategoryModel(value: '5000users入り', name: '5000users入り', check: false),
                          CategoryModel(value: '500users入り', name: '500users入り', check: false),
                          CategoryModel(value: '300users入り', name: '300users入り', check: false),
                          CategoryModel(value: '100users入り', name: '100users入り', check: false),
                          CategoryModel(value: '50users入り', name: '50users入り', check: false),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
            return SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: SliverWidgetPersistentHeaderDelegate(
                maxHeight: searchType != SearchType.user ? 50 : 0,
                minHeight: searchType != SearchType.user ? 50 : 0,
                child: Visibility(visible: searchType != SearchType.user, child: widget),
              ),
            );
          })),

          /// 搜索结果
          Consumer(
            builder: (_, ref, __) {
              SearchType searchType = ref.watch(searchTypeProvider);
              switch (searchType) {
                case SearchType.artwork:
                  return Builder(builder: ((context) {
                    final list = ref.watch(searchArtworksProvider);
                    return list.when(
                      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
                      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
                        child: Center(
                          child: RequestLoadingFailed(
                            onRetry: () async => ref.read(searchArtworksProvider.notifier).reload(),
                          ),
                        ),
                      ),
                      data: (data) {
                        return SliverIllustWaterfallGridView(
                          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0.0),
                          artworkList: data,
                          onLazyload: () async => ref.read(searchArtworksProvider.notifier).next(),
                        );
                      },
                    );
                  }));
                case SearchType.novel:
                  return ref.watch(searchNovelsProvider).when(
                        data: (data) => SliverNovelListView(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          novelList: data,
                          onLazyload: () async => ref.read(searchNovelsProvider.notifier).next(),
                        ),
                        loading: () => const SliverToBoxAdapter(child: RequestLoading()),
                        error: (error, stackTrace) => SliverToBoxAdapter(
                            child: RequestLoadingFailed(
                          onRetry: () async => ref.read(searchNovelsProvider.notifier).reload(),
                        )),
                      );
                case SearchType.user:
                  return ref.watch(searchUsersProvider).when(
                        data: (data) => SliverUserVerticalListView(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          userList: data,
                          onLazyload: () async => ref.read(searchUsersProvider.notifier).next(),
                        ),
                        loading: () => const SliverToBoxAdapter(child: RequestLoading()),
                        error: (error, stackTrace) => SliverToBoxAdapter(
                          child: RequestLoadingFailed(
                            onRetry: () async => ref.read(searchUsersProvider.notifier).reload(),
                          ),
                        ),
                      );
              }
            },
          ),
        ],
      ),
    );
  }
}
