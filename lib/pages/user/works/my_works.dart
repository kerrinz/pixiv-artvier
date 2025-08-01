import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/business_component/listview/novel_listview/novel_list.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/pages/user/detail/provider/user_works_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyWorksPage extends ConsumerStatefulWidget {
  final String userId;

  const MyWorksPage(Object arguments, {super.key}) : userId = arguments as String;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyWorksPageState();
}

class MyWorksPageState extends BasePageState<MyWorksPage> with AutomaticKeepAliveClientMixin, _Logic {
  @override
  bool get wantKeepAlive => true;

  @override
  String get userId => widget.userId;

  final filters = [
    WorksType.illust,
    WorksType.manga,
    WorksType.novel,
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myWorks),
      ),
      body: RefreshIndicator(
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
                      selectedBackground: colorScheme.secondary,
                      unselectedBackground: colorScheme.surface,
                      selectedTextStyle: TextStyle(fontSize: 12, color: colorScheme.onSecondary),
                      unselectedTextStyle: TextStyle(fontSize: 12, color: colorScheme.secondary),
                      textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      textBorderRadius: const BorderRadius.all(Radius.circular(20)),
                      spacing: 8,
                      onTap: (int tapIndex) => handleTapFilter(filters[tapIndex]),
                      texts: [l10n.illust, l10n.manga, l10n.novels],
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
                switch (worksType) {
                  case WorksType.novel:
                    return _novelsWidget();
                  case WorksType.illust:
                    return _illustWidget();
                  case WorksType.manga:
                  case WorksType.mangaSeries:
                    return _mangaWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 插画列表
  Widget _illustWidget() {
    return Consumer(builder: (_, ref, __) {
      return ref.watch(illustWorksProvider).when(
          data: (data) => SliverIllustWaterfallGridView(
                artworkList: data,
                onLazyload: () async => ref.read(illustWorksProvider.notifier).next(),
              ),
          error: (_, __) => SliverToBoxAdapter(
                child: RequestLoadingFailed(
                  onRetry: () async => ref.read(illustWorksProvider.notifier).reload(),
                ),
              ),
          loading: () => const SliverToBoxAdapter(child: RequestLoading()));
    });
  }

  /// 漫画列表
  Widget _mangaWidget() {
    return Consumer(builder: (_, ref, __) {
      return ref.watch(mangaWorksProvider).when(
          data: (data) => SliverIllustWaterfallGridView(
                artworkList: data,
                onLazyload: () async => ref.read(mangaWorksProvider.notifier).next(),
              ),
          error: (_, __) => SliverToBoxAdapter(
                child: RequestLoadingFailed(
                  onRetry: () async => ref.read(mangaWorksProvider.notifier).reload(),
                ),
              ),
          loading: () => const SliverToBoxAdapter(child: RequestLoading()));
    });
  }

  /// 小说列表
  Widget _novelsWidget() {
    return Consumer(builder: (_, ref, __) {
      return ref.watch(novelWorksProvider).when(
          data: (data) => SliverNovelListView(
                novelList: data,
                onLazyload: () async => ref.read(novelWorksProvider.notifier).next(),
              ),
          error: (_, __) => SliverToBoxAdapter(
                child: RequestLoadingFailed(
                  onRetry: () async => ref.read(novelWorksProvider.notifier).reload(),
                ),
              ),
          loading: () => const SliverToBoxAdapter(child: RequestLoading()));
    });
  }
}

mixin _Logic on ConsumerState<MyWorksPage> {
  String get userId;

  /// 作品类型筛选
  final worksTypeProvider = StateProvider.autoDispose((ref) => WorksType.illust);

  /// 插画
  late final illustWorksProvider = AutoDisposeAsyncNotifierProvider<UserIllustWorksNotifier, List<CommonIllust>>(
      () => UserIllustWorksNotifier(userId: userId));

  /// 漫画
  late final mangaWorksProvider = AutoDisposeAsyncNotifierProvider<UserMangaWorksNotifier, List<CommonIllust>>(
      () => UserMangaWorksNotifier(userId: userId));

  /// 小说
  late final novelWorksProvider = AutoDisposeAsyncNotifierProvider<UserNovelWorksNotifier, List<CommonNovel>>(
      () => UserNovelWorksNotifier(userId: userId));

  ///  下拉刷新
  Future<void> handleRefresh() async {
    switch (ref.read(worksTypeProvider)) {
      case WorksType.novel:
        return ref.read(novelWorksProvider.notifier).refresh();
      case WorksType.illust:
        return ref.read(illustWorksProvider.notifier).refresh();
      case WorksType.manga:
      case WorksType.mangaSeries:
        return ref.read(mangaWorksProvider.notifier).refresh();
    }
  }

  /// 切换作品
  handleTapFilter(WorksType worksType) {
    ref.read(worksTypeProvider.notifier).update((state) => worksType);
  }
}
