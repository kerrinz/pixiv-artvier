import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/routes.dart';
import 'package:artvier/storage/viewing_history/viewing_history_db.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/lazyload_logic_mixin.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

/// 历史记录列表组件
class HistoryGridView extends ConsumerWidget with LazyloadLogic {
  /// 列表
  final List<ViewingHistoryTableData> itemList;

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

  HistoryGridView({
    super.key,
    required this.itemList,
    required this.onLazyload,
    this.lazyloadState,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.scrollController,
    this.physics,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WaterfallFlow.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemCount: itemList.length + 1,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        collectGarbage: collectGarbage,
        viewportBuilder: viewportBuilder,
        lastChildLayoutTypeBuilder: (index) =>
            index == itemList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
      ),
      itemBuilder: (BuildContext context, int index) => itemBuilder(ref, index),
    );
  }

  void collectGarbage(List<int> garbages) {
    for (var index in garbages) {
      if (itemList[index].previewImageUrl != null) {
        final provider = ExtendedNetworkImageProvider(
          HttpHostOverrides().pxImgUrl(itemList[index].previewImageUrl!),
        );
        provider.evict();
      }
    }
  }

  void viewportBuilder(int firstIndex, int lastIndex) {
    // print('viewport : [$firstIndex,$lastIndex]');
  }

  Widget itemBuilder(WidgetRef ref, index) {
    // 如果滑动到了表尾加载更多的项
    if (index == itemList.length) {
      handleViewLazyloadWidget(ref, onLazyload);
      // 尾部懒加载组件
      return lazyloadWidget(ref);
    }
    var item = itemList[index];
    return HistoryIllustItem(
      imageUrl: item.previewImageUrl ?? "",
      title: item.title,
      author: item.authorName ?? "",
      onTap: () {
        Navigator.of(ref.context).pushNamed(
          RouteNames.artworkDetail.name,
          arguments: IllustDetailPageArguments(illustId: item.worksId, title: item.title),
        );
      },
    );
  }

  /// 懒加载组件的构建
  Widget lazyloadWidget(WidgetRef ref) => Consumer(
        builder: ((context, ref, _) {
          /// TODO: 历史记录需要分页支持，原逻辑有问题
          var lazyloadState = LazyloadState.noMore;
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

/// See [HistoryGridView].
class SliverHistoryGridView extends HistoryGridView {
  SliverHistoryGridView({
    super.key,
    required super.itemList,
    required super.onLazyload,
    super.lazyloadState,
    super.scrollController,
    super.physics,
    super.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              index == itemList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => itemBuilder(ref, index),
          childCount: itemList.length + 1,
        ),
      ),
    );
  }
}

/// 历史记录列表的插画项
class HistoryIllustItem extends StatelessWidget {
  const HistoryIllustItem({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.title,
    required this.author,
    required this.imageUrl,
  });

  final GestureTapCallback? onTap;

  final GestureLongPressCallback? onLongPress;

  final String title;

  final String author;

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                height: constraints.maxWidth,
                width: constraints.maxWidth,
                child: EnhanceNetworkImage(
                  image: ExtendedNetworkImageProvider(
                    HttpHostOverrides().pxImgUrl(imageUrl),
                    headers: HttpHostOverrides().pximgHeaders,
                  ),
                ),
              );
            },
          ),
          // 阴影遮罩和文案层
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0x00000000),
                  Color(0x00000000),
                  Color(0x00000000),
                  Color(0x6C000000),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                  Text(author, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
          // 触控交互层
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black12.withOpacity(0.15),
                highlightColor: Colors.black12.withOpacity(0.1),
                onTap: () {},
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onTap,
                  onLongPress: onLongPress,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 历史记录列表的插画项
class HistoryNovelItem extends StatelessWidget {
  const HistoryNovelItem({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.title,
    required this.author,
    required this.imageUrl,
  });

  final Function? onTap;

  final Function? onLongPress;

  final String title;

  final String author;

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
      onLongPress: () => onLongPress,
      child: EnhanceNetworkImage(
        image: ExtendedNetworkImageProvider(
          HttpHostOverrides().pxImgUrl(imageUrl),
          headers: HttpHostOverrides().pximgHeaders,
        ),
      ),
    );
  }
}
