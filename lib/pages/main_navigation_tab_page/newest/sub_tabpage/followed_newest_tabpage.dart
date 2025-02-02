import 'package:artvier/business_component/listview/novel_listview/novel_list.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/filter_dropdown/filter_dropdown_list.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/widgets/recommend_users_widget.dart';
import 'package:artvier/pages/user/recommend/provider/recommend_users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/provider/followed_newest_provider.dart';

class FollowedNewestTabPage extends BaseStatefulPage {
  const FollowedNewestTabPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedNewestTabPageState();
}

class _FollowedNewestTabPageState extends BasePageState<FollowedNewestTabPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final filters = [
    WorksType.illust,
    WorksType.novel,
  ];
  final layerlink = LayerLink();

  final dropDownMenuController = DropDownMenuController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final pageState = ref.watch(followedNewestPageStateProvider);
    if (pageState == PageState.error) {
      return RequestLoadingFailed(onRetry: () {});
    } else if (pageState == PageState.loading) {
      return const RequestLoading();
    }
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(recommendUsersProvider.notifier).refresh();
        final worksType = ref.read(followedNewestWorksTypeProvider);
        if (worksType == WorksType.novel) {
          return await ref.read(followedNewestNovelsProvider.notifier).refresh();
        } else {
          return await ref.read(followedNewestArtworksProvider.notifier).refresh();
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            delegate: SliverWidgetPersistentHeaderDelegate(
              maxHeight: 48,
              minHeight: 48,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: colorScheme.background),
                child: CompositedTransformTarget(
                  link: layerlink,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Consumer(builder: (_, ref, __) {
                            final worksType = ref.watch(followedNewestWorksTypeProvider);
                            int index = filters.indexOf(worksType);
                            return StatelessTextFlowFilter(
                              initialIndexes: {index >= 0 ? index : 0},
                              selectedBackground: Theme.of(context).colorScheme.secondary,
                              unselectedBackground: Theme.of(context).colorScheme.surface,
                              selectedTextStyle:
                                  TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
                              unselectedTextStyle:
                                  TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                              textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              textBorderRadius: const BorderRadius.all(Radius.circular(20)),
                              spacing: 8,
                              onTap: (int tapIndex) {
                                final workTypeNotifier = ref.read(followedNewestWorksTypeProvider.notifier);
                                final artworkNotifilter = ref.read(followedNewestArtworksProvider.notifier);
                                final novelNotifilter = ref.read(followedNewestNovelsProvider.notifier);
                                if (tapIndex == 0 &&
                                    ![WorksType.illust, WorksType.manga, WorksType.mangaSeries]
                                        .contains(workTypeNotifier.state)) {
                                  workTypeNotifier.update((state) => WorksType.illust);
                                } else if (tapIndex == 1 && WorksType.novel != workTypeNotifier.state) {
                                  workTypeNotifier.update((state) => WorksType.novel);
                                }
                                // Check filters and refresh
                                final restrict = ref.read(followedNewestRestrictAllProvider.notifier).state;
                                final illustRestrict = artworkNotifilter.restrictFilter;
                                if (illustRestrict != restrict) {
                                  artworkNotifilter.reload();
                                }
                                final novelRestrict = novelNotifilter.restrictFilter;
                                if (novelRestrict != restrict) {
                                  novelNotifilter.reload();
                                }
                              },
                              texts: ["${l10n.illust} • ${l10n.manga}", l10n.novels],
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropDownMenu(
                          controller: dropDownMenuController,
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                          layerLink: layerlink,
                          onChange: (index, value) {
                            final restrict = value == 'public'
                                ? RestrictAll.public
                                : value == 'private'
                                    ? RestrictAll.private
                                    : RestrictAll.all;
                            ref.read(followedNewestRestrictAllProvider.notifier).update((state) => restrict);
                            final currentWorkType = ref.read(followedNewestWorksTypeProvider.notifier).state;
                            if (WorksType.novel == currentWorkType) {
                              ref.read(followedNewestNovelsProvider.notifier).reload();
                            } else {
                              ref.read(followedNewestArtworksProvider.notifier).reload();
                            }
                          },
                          filterList: [
                            DropDownMenuModel(
                              name: l10n.all,
                              defaultValue: RestrictAll.all.name,
                              list: [
                                CategoryModel(value: RestrictAll.all.name, name: l10n.all, check: false),
                                CategoryModel(value: RestrictAll.public.name, name: l10n.public, check: false),
                                CategoryModel(value: RestrictAll.private.name, name: l10n.private, check: false),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer(
              builder: (context, value, child) {
                final recommend = ref.watch(recommendUsersProvider);
                final users = recommend.value;
                return Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 12, left: 12, right: 12),
                  child: RecommendUsersWidget(
                    users: users ?? [],
                  ),
                );
              },
            ),
          ),
          Consumer(
            builder: (context, value, child) {
              final worksType = ref.watch(followedNewestWorksTypeProvider);
              if (worksType == WorksType.novel) {
                return const FollowedNewestNovelPageView();
              } else {
                return const FollowedNewestIllustPageView();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FollowedNewestIllustPageView extends ConsumerStatefulWidget {
  const FollowedNewestIllustPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedNewestIllustPageViewState();
}

class _FollowedNewestIllustPageViewState extends ConsumerState<FollowedNewestIllustPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(followedNewestArtworksProvider);
    return list.when(
      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: RequestLoadingFailed(
            onRetry: () async => ref.read(followedNewestArtworksProvider.notifier).reload(),
          ),
        ),
      ),
      data: (List<CommonIllust> data) {
        return SliverIllustWaterfallGridView(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0.0),
          artworkList: data,
          onLazyload: () async => ref.read(followedNewestArtworksProvider.notifier).next(),
        );
      },
    );
  }
}

class FollowedNewestNovelPageView extends ConsumerStatefulWidget {
  const FollowedNewestNovelPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedNewestNovelPageViewState();
}

class _FollowedNewestNovelPageViewState extends ConsumerState<FollowedNewestNovelPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(followedNewestNovelsProvider);
    return list.when(
      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: RequestLoadingFailed(
            onRetry: () async => ref.read(followedNewestNovelsProvider.notifier).reload(),
          ),
        ),
      ),
      data: (List<CommonNovel> data) {
        return SliverNovelListView(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0.0),
          novelList: data,
          onLazyload: () async => ref.read(followedNewestNovelsProvider.notifier).next(),
        );
      },
    );
  }
}
