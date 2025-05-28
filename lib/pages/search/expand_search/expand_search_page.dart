import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/pages/main_navigation_tab_page/search/provider/search_input_provider.dart';
import 'package:artvier/pages/search/expand_search/provider.dart';
import 'package:artvier/pages/search/expand_search/widget/predictive_search_user_item.dart';
import 'package:artvier/pages/search/expand_search/widget/search_input.dart';
import 'package:artvier/pages/search/result/provider/search_filters_provider.dart';
import 'package:artvier/routes.dart';
import 'package:artvier/util/event_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 从搜索框完整展开后的搜索页
class ExpandSearchPage extends ConsumerStatefulWidget {
  const ExpandSearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpandSearchPageState();
}

class _ExpandSearchPageState extends BasePageState<ExpandSearchPage> {
  late final TextEditingController _textController;

  late final FocusNode _focusNode;

  /// 所有的搜索类型
  final List<SearchType> _searchTypes = [SearchType.artwork, SearchType.novel, SearchType.user];

  @override
  void initState() {
    _textController = TextEditingController();
    _textController.addListener(() {
      EventUtil.debounce(predictiveSearch);
    });
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height:
                (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) + MediaQuery.of(context).padding.top,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 10, left: 0, right: 0),
              color: colorScheme.surface,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SearchInput(
                      focusNode: _focusNode,
                      textController: _textController,
                    ),
                  )),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(l10n.promptCancel),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
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
          Expanded(
            child: CustomScrollView(
              slivers: [
                Consumer(builder: (_, ref, __) {
                  final worksPreSearch = ref.watch(predictiveSearchWorksProvider).value;
                  final usersPreSearch = ref.watch(predictiveSearchUsersProvider).value;
                  final searchType = ref.watch(searchTypeProvider);
                  if ((searchType == SearchType.user && (usersPreSearch?.length ?? 0) == 0) ||
                      (searchType == SearchType.artwork && (worksPreSearch?.length ?? 0) == 0) ||
                      (searchType == SearchType.novel && (worksPreSearch?.length ?? 0) == 0)) {
                    return const SliverPadding(padding: EdgeInsets.zero);
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
                    sliver: SliverToBoxAdapter(
                      child: Text('${l10n.youMayWantToSearch}:'),
                    ),
                  );
                }),
                SliverPadding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: MediaQuery.paddingOf(context).bottom),
                  sliver: Consumer(
                    builder: (_, ref, __) {
                      final worksPreSearch = ref.watch(predictiveSearchWorksProvider).value;
                      final usersPreSearch = ref.watch(predictiveSearchUsersProvider).value;
                      final searchType = ref.watch(searchTypeProvider);
                      if (searchType == SearchType.user) {
                        return usersPreSearch != null
                            ? SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  childCount: usersPreSearch.length,
                                  (context, index) {
                                    final item = usersPreSearch[index];
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                                        child: PredictiveSearchUserItem(
                                          user: item,
                                          onTap: () {
                                            Navigator.of(ref.context).pushNamed(
                                              RouteNames.userDetail.name,
                                              arguments: PreloadUserLeastInfo(
                                                item.user.id.toString(),
                                                item.user.name,
                                                item.user.profileImageUrls.medium,
                                              ),
                                            );
                                          },
                                        ));
                                  },
                                ),
                              )
                            : const SliverPadding(padding: EdgeInsets.zero);
                      } else {
                        return worksPreSearch != null
                            ? SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  childCount: worksPreSearch.length,
                                  (context, index) {
                                    final item = worksPreSearch[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: colorScheme.surface,
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              splashFactory: InkSparkle.splashFactory,
                                              onTap: () {
                                                // 跳转搜索结果页面
                                                Navigator.of(context)
                                                    .pushNamed(RouteNames.searchResult.name, arguments: item.name);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                                child: Text(
                                                  item.name,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const SliverPadding(padding: EdgeInsets.zero);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  predictiveSearch() {
    final searchType = ref.read(searchTypeProvider);
    if (searchType == SearchType.artwork || searchType == SearchType.novel) {
      ref.read(predictiveSearchWorksProvider.notifier).search(ref.read(searchInputProvider));
    } else {
      ref.read(predictiveSearchUsersProvider.notifier).search(ref.read(searchInputProvider));
    }
  }

  /// 点击切换搜索类型
  void handleTapSearchType(SearchType searchType) {
    ref.read(searchTypeProvider.notifier).update((state) => searchType);
    predictiveSearch();
  }
}
