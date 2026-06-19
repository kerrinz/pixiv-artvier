import 'package:artvier/global/settings.dart';
import 'package:artvier/global/provider/muted_state_provider.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/lazyload_logic_mixin.dart';
import 'package:artvier/business_component/listview/novel_listview/logic.dart';
import 'package:artvier/business_component/listview/novel_listview/novel_list_item.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

/// 小说的瀑布流列表
class NovelListView extends ConsumerWidget
    with LazyloadLogic, NovelListViewLogic {
  /// 小说列表
  final List<CommonNovel> novelList;

  /// 懒加载异步事件
  /// - return bool of hasMore. 需要返回是否还有更多数据
  /// - 当[lazyloadState] = [LazyloadState.loading]/[LazyloadState.noMore] 时**不会执行**此函数
  @override
  final Future<bool> Function() onLazyload;

  /// 赋值后本组件将不再负责懒加载状态，转变为静态组件
  final LazyloadState? lazyloadState;

  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  late WidgetRef ref;

  NovelListView({
    super.key,
    required this.novelList,
    required this.onLazyload,
    this.lazyloadState,
    this.crossAxisCount = 1,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.scrollController,
    this.physics,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    final mutedState = ref.watch(globalMutedStateProvider);
    final visibleNovelList =
        novelList.where((novel) => !mutedState.containsNovel(novel)).toList();
    return WaterfallFlow.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemCount: visibleNovelList.length + 1,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        collectGarbage: (garbages) =>
            collectGarbage(garbages, visibleNovelList),
        viewportBuilder: viewportBuilder,
      ),
      itemBuilder: (BuildContext context, int index) =>
          itemBuilder(ref, index, visibleNovelList),
    );
  }

  void collectGarbage(List<int> garbages, List<CommonNovel> visibleNovelList) {
    // print('collect garbage : $garbages');
    // 根据画质设置，选用合适的图片
    final quality = GlobalSettings.instance.listPreviewQuality;
    for (var index in garbages) {
      if (index < 0 || index >= visibleNovelList.length) continue;
      final imageUrl = quality == ListPreviewQuality.medium
          ? visibleNovelList[index].imageUrls.medium
          : visibleNovelList[index].imageUrls.large;
      final provider = ExtendedNetworkImageProvider(
        HttpHostOverrides().pxImgUrl(imageUrl),
      );
      provider.evict();
    }
  }

  void viewportBuilder(int firstIndex, int lastIndex) {
    // print('viewport : [$firstIndex,$lastIndex]');
  }

  Widget itemBuilder(WidgetRef ref, index, List<CommonNovel> visibleNovelList) {
    // 如果滑动到了表尾加载更多的项
    if (index == visibleNovelList.length) {
      handleViewLazyloadWidget(ref, onLazyload);
      // 尾部懒加载组件
      return lazyloadWidget(ref);
    }
    var novel = visibleNovelList[index];
    return NovelWaterfallItem(
      novel: novel,
      collectState: novel.collectState ??
          (novel.isBookmarked
              ? CollectState.collected
              : CollectState.notCollect),
      onTap: () => handleTapItem(novel),
    );
  }

  /// 懒加载组件的构建
  Widget lazyloadWidget(WidgetRef ref) => Consumer(
        builder: ((context, ref, _) {
          var lazyloadState = ref.watch(lazyloadStateProvider);
          Map<LazyloadState, Widget> map = {
            LazyloadState.idle: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const CircularProgressIndicator(strokeWidth: 1.0),
            ),
            LazyloadState.loading: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const CircularProgressIndicator(strokeWidth: 1.0),
            ),
            LazyloadState.noMore: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text("没有更多了", style: TextStyle(color: Colors.grey)),
            ),
            LazyloadState.error: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: LazyloadingFailedWidget(
                onRetry: () => handleRetry(ref),
              ),
            ),
          };
          return SafeArea(
              left: true,
              top: false,
              right: true,
              bottom: true,
              child: map[lazyloadState]!);
        }),
      );
}

/// See [NovelListView].
class SliverNovelListView extends NovelListView {
  SliverNovelListView({
    super.key,
    required super.novelList,
    required super.onLazyload,
    super.lazyloadState,
    super.scrollController,
    super.physics,
    super.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    final mutedState = ref.watch(globalMutedStateProvider);
    final visibleNovelList =
        novelList.where((novel) => !mutedState.containsNovel(novel)).toList();
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          collectGarbage: (garbages) =>
              collectGarbage(garbages, visibleNovelList),
          viewportBuilder: viewportBuilder,
          lastChildLayoutTypeBuilder: (index) =>
              index == visibleNovelList.length
                  ? LastChildLayoutType.fullCrossAxisExtent
                  : LastChildLayoutType.none,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) =>
              itemBuilder(ref, index, visibleNovelList),
          childCount: visibleNovelList.length + 1,
        ),
      ),
    );
  }
}
