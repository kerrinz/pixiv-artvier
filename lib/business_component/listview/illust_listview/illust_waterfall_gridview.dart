import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_item.dart';
import 'package:artvier/business_component/listview/illust_listview/logic.dart';
import 'package:artvier/business_component/listview/lazyload_logic_mixin.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

/// 插画瀑布流
/// - 默认为非静态组件！
/// - 全权负责管理懒加载的状态，其他状态不在范围内。
/// - 请不要为 [onLazyload] 捕获异常，否则会导致懒加载区域无法显示 errorWidget
class IllustWaterfallGridView extends ConsumerWidget with LazyloadLogic, IllustWaterfallGridViewLogic {
  /// 插画（或漫画）列表
  final List<CommonIllust> artworkList;

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
  late final WidgetRef ref;

  IllustWaterfallGridView({
    Key? key,
    required this.artworkList,
    required this.onLazyload,
    this.lazyloadState,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.scrollController,
    this.physics,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    return WaterfallFlow.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemCount: artworkList.length + 1,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        collectGarbage: collectGarbage,
        viewportBuilder: viewportBuilder,
        lastChildLayoutTypeBuilder: (index) =>
            index == artworkList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
      ),
      itemBuilder: (BuildContext context, int index) => itemBuilder(ref, index),
    );
  }

  void collectGarbage(List<int> garbages) {
    // print('collect garbage : $garbages');
    for (var index in garbages) {
      final provider = ExtendedNetworkImageProvider(
        HttpHostOverrides().pxImgUrl(artworkList[index].imageUrls.medium),
      );
      provider.evict();
    }
  }

  void viewportBuilder(int firstIndex, int lastIndex) {
    // print('viewport : [$firstIndex,$lastIndex]');
  }

  Widget itemBuilder(WidgetRef ref, index) {
    // 如果滑动到了表尾加载更多的项
    if (index == artworkList.length) {
      handleViewLazyloadWidget(ref, onLazyload);
      // 尾部懒加载组件
      return lazyloadWidget(ref);
    }
    var illust = artworkList[index];
    return IllustWaterfallItem(
      worksId: illust.id.toString(),
      imageUrl: illust.imageUrls.medium,
      imageHeight: illust.height,
      imageWidth: illust.width,
      title: illust.title,
      author: illust.user.name,
      totalCollected: illust.totalBookmarks,
      collectState: illust.collectState ?? (illust.isBookmarked ? CollectState.collected : CollectState.notCollect),
      onTap: () => handleTapItem(illust),
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
          return SafeArea(left: true, top: false, right: true, bottom: true, child: map[lazyloadState]!);
        }),
      );
}

/// See [IllustWaterfallGridView].
class SliverIllustWaterfallGridView extends IllustWaterfallGridView {
  SliverIllustWaterfallGridView({
    super.key,
    required super.artworkList,
    required super.onLazyload,
    super.lazyloadState,
    super.scrollController,
    super.physics,
    super.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          collectGarbage: collectGarbage,
          viewportBuilder: viewportBuilder,
          lastChildLayoutTypeBuilder: (index) =>
              index == artworkList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => itemBuilder(ref, index),
          childCount: artworkList.length + 1,
        ),
      ),
    );
  }
}
