import 'package:artvier/business_component/input/search_box.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/config/enums.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/component/trending_tags_grid.dart';
import 'package:artvier/pages/main_navigation_tab_page/search/provider/trend_tags_provider.dart';

class SearchTabPage extends BaseStatefulPage {
  const SearchTabPage({super.key});

  @override
  BasePageState<BaseStatefulPage> createState() {
    return SearchTabPageState();
  }
}

class SearchTabPageState extends BasePageState<SearchTabPage> with AutomaticKeepAliveClientMixin {
  late final TextEditingController _textController;

  late final FocusNode _focusNode;

  static const filters = [
    WorksType.illust,
    WorksType.novel,
  ];

  @override
  void initState() {
    _textController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedNestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverWidgetPersistentHeaderDelegate(
              maxHeight:
                  (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) + MediaQuery.of(context).padding.top,
              minHeight:
                  (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) + MediaQuery.of(context).padding.top,
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 10, left: 10, right: 10),
                height: double.infinity,
                color: colorScheme.surface,
                child: const SearchBox(),
              ),
            ),
          ),
        ];
      },
      // 内容主体
      body: RefreshIndicator(
        onRefresh: () async {
          final worksType = ref.read(trendTagsWorksTypeProvider);
          if (worksType == WorksType.novel) {
            return await ref.read(novelTrendTagsProvider.notifier).refresh();
          } else {
            return ref.read(artworkTrendTagsProvider.notifier).refresh();
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(i10n.trendingTags, style: textTheme.titleLarge),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Consumer(builder: (_, ref, __) {
                        final worksType = ref.watch(trendTagsWorksTypeProvider);
                        int index = filters.indexOf(worksType);
                        return StatelessTextFlowFilter(
                          initialIndexes: {index >= 0 ? index : 0},
                          selectedBackground: Theme.of(context).colorScheme.secondary,
                          unselectedBackground: Theme.of(context).colorScheme.surface,
                          selectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
                          unselectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                          textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          textBorderRadius: const BorderRadius.all(Radius.circular(20)),
                          spacing: 8,
                          onTap: (int tapIndex) {
                            final workTypeNotifier = ref.read(trendTagsWorksTypeProvider.notifier);
                            if (tapIndex == 0 &&
                                ![WorksType.illust, WorksType.manga, WorksType.mangaSeries]
                                    .contains(workTypeNotifier.state)) {
                              workTypeNotifier.update((state) => WorksType.illust);
                            } else if (tapIndex == 1 && WorksType.novel != workTypeNotifier.state) {
                              workTypeNotifier.update((state) => WorksType.novel);
                            }
                          },
                          texts: ["${i10n.illust} • ${i10n.manga}", i10n.novels],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 4, bottom: 12, left: 12, right: 12),
              sliver: Consumer(
                builder: (_, ref, __) {
                  final worksType = ref.watch(trendTagsWorksTypeProvider);
                  if (worksType == WorksType.novel) {
                    return const TrendingTagsNovelPageView();
                  } else {
                    return const TrendingTagsIllustPageView();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingTagsIllustPageView extends ConsumerStatefulWidget {
  const TrendingTagsIllustPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrendingTagsIllustPageViewState();
}

class _TrendingTagsIllustPageViewState extends ConsumerState<TrendingTagsIllustPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(artworkTrendTagsProvider);
    return list.when(
      data: (data) => SliverTrendingTagsGrid(
        tags: data,
      ),
      error: (error, stackTrace) => SliverToBoxAdapter(
        child: RequestLoadingFailed(onRetry: () => ref.read(artworkTrendTagsProvider.notifier).reload()),
      ),
      loading: () => const SliverToBoxAdapter(child: RequestLoading()),
    );
  }
}

class TrendingTagsNovelPageView extends ConsumerStatefulWidget {
  const TrendingTagsNovelPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrendingTagsNovelPageViewState();
}

class _TrendingTagsNovelPageViewState extends ConsumerState<TrendingTagsNovelPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(novelTrendTagsProvider);
    return list.when(
      data: (data) => SliverTrendingTagsGrid(
        tags: data,
      ),
      error: (error, stackTrace) => SliverToBoxAdapter(
        child: RequestLoadingFailed(onRetry: () => ref.read(novelTrendTagsProvider.notifier).reload()),
      ),
      loading: () => const SliverToBoxAdapter(child: RequestLoading()),
    );
  }
}
