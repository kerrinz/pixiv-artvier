import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/business_component/listview/novel_listview/novel_list.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/pages/user/detail/provider/user_collections_provider.dart';

class UserCollectionsTabPage extends ConsumerStatefulWidget {
  final String userId;

  const UserCollectionsTabPage({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => UserCollectionsTabPageState();
}

class UserCollectionsTabPageState extends ConsumerState<UserCollectionsTabPage> with AutomaticKeepAliveClientMixin, _Logic {
  @override
  bool get wantKeepAlive => true;

  @override
  String get userId => widget.userId;

  final filters = [
    WorksType.illust,
    WorksType.novel,
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => handleRefresh,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            delegate: SliverWidgetPersistentHeaderDelegate(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Consumer(builder: (_, ref, __) {
                  var worksType = ref.watch(worksTypeProvider);
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
                    onTap: (int tapIndex) => handleTapFilter(filters[tapIndex]),
                    texts: [
                      "${LocalizationIntl.of(context).illust} • ${LocalizationIntl.of(context).manga}",
                      LocalizationIntl.of(context).novels
                    ],
                  );
                }),
              ),
              maxHeight: 46,
              minHeight: 46,
            ),
          ),
          Consumer(
            builder: (_, ref, __) {
              var worksType = ref.watch(worksTypeProvider);
              return worksType == WorksType.novel ? _novelsWidget() : _artworksWidget();
            },
          ),
        ],
      ),
    );
  }

  /// 插画漫画列表
  Widget _artworksWidget() {
    return Consumer(builder: (_, ref, __) {
      return ref.watch(artworksCollectionsProvider).when(
          data: (data) => SliverIllustWaterfallGridView(
                artworkList: data,
                onLazyload: () async => ref.read(artworksCollectionsProvider.notifier).next(),
              ),
          error: (_, __) => SliverToBoxAdapter(
                child: RequestLoadingFailed(
                  onRetry: () async => ref.read(artworksCollectionsProvider.notifier).reload(),
                ),
              ),
          loading: () => const SliverToBoxAdapter(child: RequestLoading()));
    });
  }

  /// 小说列表
  Widget _novelsWidget() {
    return Consumer(builder: (_, ref, __) {
      return ref.watch(novelCollectionsProvider).when(
          data: (data) => SliverNovelListView(
                novelList: data,
                onLazyload: () async => ref.read(novelCollectionsProvider.notifier).next(),
              ),
          error: (_, __) => SliverToBoxAdapter(
                child: RequestLoadingFailed(
                  onRetry: () async => ref.read(novelCollectionsProvider.notifier).reload(),
                ),
              ),
          loading: () => const SliverToBoxAdapter(child: RequestLoading()));
    });
  }
}

mixin _Logic on ConsumerState<UserCollectionsTabPage> {
  String get userId;

  /// 作品类型筛选
  final worksTypeProvider = StateProvider.autoDispose((ref) => WorksType.illust);

  /// 收藏插画漫画
  late final artworksCollectionsProvider =
      AutoDisposeAsyncNotifierProvider<UserArtworkCollectionsNotifier, List<CommonIllust>>(
          () => UserArtworkCollectionsNotifier(userId: userId));

  /// 收藏小说
  late final novelCollectionsProvider =
      AutoDisposeAsyncNotifierProvider<UserNovelCollectionsNotifier, List<CommonNovel>>(
          () => UserNovelCollectionsNotifier(userId: userId));

  ///  下拉刷新
  Future<void> handleRefresh() async {
    return ref.read(worksTypeProvider) == WorksType.novel
        ? ref.read(novelCollectionsProvider.notifier).refresh()
        : ref.read(artworksCollectionsProvider.notifier).refresh();
  }

  /// 切换作品
  handleTapFilter(WorksType worksType) {
    ref.read(worksTypeProvider.notifier).update((state) => worksType);
  }
}
