import 'dart:io';

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

  const SearchResultPage(Object arguments, {super.key})
      : label = arguments as String;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchResultPageState();
}

class SearchResultPageState extends ConsumerState<SearchResultPage> with WidgetsBindingObserver, SearchResultPageLogic {
  late TextEditingController _textController;

  late final FocusNode _focusNode;

  /// 键盘是否激活状态
  bool isKeyboardActived = false;

  /// 所有的搜索类型
  final List<SearchType> _searchTypes = [SearchType.artwork, SearchType.novel, SearchType.user];

  LocalizationIntl get i10n => LocalizationIntl.of(context);

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.label);
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
        titleSpacing: 0,
        title: Container(
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15), borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          child: TextField(
            controller: _textController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            autofocus: false,
            focusNode: _focusNode,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: "${i10n.search}...",
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
        actions: [
          // 筛选按钮
          Center(
            child: Consumer(
              builder: (_, ref, __) {
                var type = ref.watch(searchTypeProvider);
                return IconButton(
                  icon: type == SearchType.user
                      ? const Icon(Icons.filter_alt_off_outlined)
                      : const Icon(Icons.filter_alt_outlined),
                  onPressed: type == SearchType.user ? null : handlePressedFilter,
                  tooltip: "more",
                );
              },
            ),
          ),
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

                  // 搜索类型的切换组件
                  return StatelessTextFlowFilter(
                    initialIndexes: {index >= 0 ? index : 0},
                    alignment: WrapAlignment.spaceAround,
                    selectedDecoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    texts: [
                      "${i10n.illust}/${i10n.manga}",
                      i10n.novels,
                      i10n.users,
                    ],
                    onTap: (int tapIndex) => handleTapSearchType(_searchTypes[tapIndex]),
                  );
                }),
              ),
            ),
          ),

          /// 搜索结果
          Consumer(
            builder: (_, ref, __) {
              SearchType searchType = ref.watch(searchTypeProvider);
              switch (searchType) {
                case SearchType.artwork:
                  return ref.watch(searchArtworksProvider).when(
                        data: (data) => SliverIllustWaterfallGridView(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          artworkList: data,
                          onLazyload: () async => ref.read(searchArtworksProvider.notifier).next(),
                        ),
                        loading: () => const SliverToBoxAdapter(child: RequestLoading()),
                        error: (error, stackTrace) => SliverToBoxAdapter(
                          child: RequestLoadingFailed(
                              onRetry: () async => ref.read(searchArtworksProvider.notifier).reload()),
                        ),
                      );
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
                              onRetry: () async => ref.read(searchNovelsProvider.notifier).reload()),
                        ),
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
                                onRetry: () async => ref.read(searchUsersProvider.notifier).reload())),
                      );
              }
            },
          ),
        ],
      ),
    );
  }
}
