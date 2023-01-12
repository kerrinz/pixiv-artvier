import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/component/loading/lazyloading.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:pixgem/routes.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'illust_waterfall_item.dart';

/// 插画瀑布流
/// - 默认为非静态组件！
/// - 全权负责管理懒加载的状态，其他状态不在范围内。
/// - 请不要为 [onLazyload] 捕获异常，否则会导致懒加载区域无法显示 errorWidget
class IllustWaterfallGridView extends ConsumerWidget with _IllustWaterfallGridViewState {
  /// 插画（或漫画）列表
  final List<CommonIllust> artworkList;

  final LazyloadState? lazyloadState;

  /// 懒加载触发事件
  /// - 当[lazyloadState] = [LazyloadState.loading] 时**不会执行**此函数，避免多次触发导致的数据重复
  final Function onLazyload;

  /// 自定义懒加载组件
  final Widget? customLazyloadWidget;

  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  IllustWaterfallGridView({
    Key? key,
    required this.artworkList,
    required this.onLazyload,
    this.lazyloadState,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.scrollController,
    this.physics,
    this.customLazyloadWidget,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WaterfallFlow.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemCount: artworkList.length + 1,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
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
        artworkList[index].imageUrls.medium,
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
      illust: artworkList[index],
      collectState: illust.isBookmarked ? CollectState.collected : CollectState.notCollect,
      onTap: () {
        // ref.read(illustDetailProvider(illust.id.toString()).notifier).setIllustInfo(illust);
        artworkList[index].restrict == 2
            ? Fluttertoast.showToast(msg: "该图片已被删除或不公开", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0)
            : Navigator.of(ref.context).pushNamed(
                RouteNames.artworkDetail.name,
                arguments: IllustDetailPageArguments(
                  illustId: illust.id.toString(),
                  detail: illust,
                ),
              );
      },
    );
  }

  /// 懒加载组件的构建
  Widget lazyloadWidget(WidgetRef ref) => Consumer(
        builder: ((context, ref, _) {
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
                onRetry: () => onLazyload(),
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
    super.customLazyloadWidget,
    super.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        collectGarbage: collectGarbage,
        viewportBuilder: viewportBuilder,
        lastChildLayoutTypeBuilder: (index) =>
            index == artworkList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => itemBuilder(ref, index),
        childCount: artworkList.length + 1,
      ),
    );
  }
}

mixin _IllustWaterfallGridViewState {
  /// 懒加载状态
  final lazyloadStateProvider = StateProvider<LazyloadState>((ref) {
    return LazyloadState.idle;
  });

  /// 当懒加载组件进入界面视图范围内时触发
  Future<void> handleViewLazyloadWidget(WidgetRef ref, Function onLazyload) async {
    if (ref.read(lazyloadStateProvider) == CollectState.collecting) {
      // 已经在加载状态中，不允许重复触发
      return;
    }
    try {
      await onLazyload();
      ref.read(lazyloadStateProvider.notifier).update((state) => LazyloadState.idle);
    } catch (e) {
      ref.read(lazyloadStateProvider.notifier).update((state) => LazyloadState.error);
    }
  }
}
