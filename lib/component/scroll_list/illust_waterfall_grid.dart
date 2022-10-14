import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/illust/illust_detail/illust_detail_page.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/routes.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'illust_waterfall_item.dart';

/// ### 插画瀑布流
/// 静态组件，故列表加载的Loading不在本组件管理范围内
///
/// **例外**：管理了懒加载Lazyload的状态（出于懒加载状态的性能考虑）
/// - #### 使用时须在本组件外套一层[ChangeNotifierProvider\<LazyloadStatusProvider\>]
/// - 通过[lazyloadWidget]参数可以自定义并管理其他懒加载组件，此时就不需要外套[LazyloadStatusProvider]
class IllustWaterfallGrid extends StatelessWidget {
  final List<CommonIllust> artworkList; // 图片含基本信息的列表
  final Function onLazyLoad; // 触发懒加载（加载更多）的时候调用
  final int? limit; // 列表项的极限数量，为空则表示不限
  final ScrollController? scrollController;
  final ScrollPhysics? physics;

  /// 自定义懒加载组件（为null时使用默认的懒加载，但需要外套一层 [ChangeNotifierProvider\<LazyloadStatusProvider\>]）
  final Widget? lazyloadWidget;
  final bool isSliver; // 是否为Sliver型组件

  const IllustWaterfallGrid({
    Key? key,
    required this.artworkList,
    required this.onLazyLoad,
    this.limit,
    this.scrollController,
    this.physics,
    this.lazyloadWidget,
  })  : isSliver = false,
        super(key: key);

  const IllustWaterfallGrid.sliver({
    Key? key,
    required this.artworkList,
    required this.onLazyLoad,
    this.limit,
    this.scrollController,
    this.physics,
    this.lazyloadWidget,
  })  : isSliver = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          collectGarbage: (List<int> garbages) {
            // print('collect garbage : $garbages');
            // 内存回收
            int end = garbages.last;
            for (int i = garbages.first; i <= end; i++) {
              final provider = CachedNetworkImageProvider(
                artworkList[i].imageUrls.medium,
              );
              provider.evict();
            }
          },
          viewportBuilder: (int firstIndex, int lastIndex) {
            // print('viewport : [$firstIndex,$lastIndex]');
          },
          lastChildLayoutTypeBuilder: (index) =>
              index == artworkList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => _buildItem(context, index),
          childCount: artworkList.length + 1,
        ),
      );
    } else {
      return WaterfallFlow.builder(
        padding: EdgeInsets.zero,
        controller: scrollController,
        physics: physics,
        itemCount: artworkList.length + 1,
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          collectGarbage: (List<int> garbages) {
            // print('collect garbage : $garbages');
            for (var index in garbages) {
              final provider = CachedNetworkImageProvider(
                artworkList[index].imageUrls.medium,
              );
              provider.evict();
            }
          },
          viewportBuilder: (int firstIndex, int lastIndex) {
            // print('viewport : [$firstIndex,$lastIndex]');
          },
          lastChildLayoutTypeBuilder: (index) =>
              index == artworkList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
        ),
        itemBuilder: (BuildContext context, int index) => _buildItem(context, index),
      );
    }
  }

  Widget _buildItem(BuildContext context, index) {
    // 如果滑动到了表尾加载更多的项
    if (index == artworkList.length) {
      // 未到列表上限，继续获取数据
      if (artworkList.length < (limit ?? double.infinity)) {
        if (artworkList.isNotEmpty) onLazyLoad(); // 列表不为空才获取数据
        // 尾部懒加载组件
        return _buildLazyloadItem(context);
      } else {
        //已经加载足够多的数据，不再获取
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "没有更多了",
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
    }
    return IllustWaterfallItem(
      illust: artworkList[index],
      isBookmarked: artworkList[index].isBookmarked,
      onTap: () => artworkList[index].restrict == 2
          ? Fluttertoast.showToast(msg: "该图片已被删除或不公开", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0)
          : Navigator.of(context).pushNamed(
              RouteNames.artworkDetail.name,
              arguments: ArtworkDetailModel(
                list: artworkList,
                index: index,
                callback: (int index, bool isBookmark) {
                  // 回调方法，传给详情页
                  artworkList[index].isBookmarked = isBookmark;
                  (context as Element).markNeedsBuild();
                },
              ),
            ),
      onTapBookmark: () async {
        var item = artworkList[index];
        try {
          bool result = await postBookmark(item.id.toString(), item.isBookmarked);
          if (result) {
            Fluttertoast.showToast(msg: "操作成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
            artworkList[index].isBookmarked = !item.isBookmarked;
          } else {
            throw Exception("http status code is not 200.");
          }
        } catch (e) {
          Fluttertoast.showToast(
              msg: "操作失败！可能已经${item.isBookmarked ? "取消" : ""}收藏了", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        }
      },
    );
  }

  Widget _buildLazyloadItem(BuildContext context) {
    return Consumer<LazyloadStatusProvider>(
      builder: ((context, LazyloadStatusProvider provider, child) {
        switch (provider.lazyloadStatus) {
          case LazyloadStatus.noMore:
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "没有更多了",
                style: TextStyle(color: Colors.grey),
              ),
            );
          case LazyloadStatus.loading:
          case LazyloadStatus.failed:
            return _buildLoading(context);
        }
      }),
    );
  }

  /* 收藏或者取消收藏插画 */
  Future<bool> postBookmark(String id, bool oldIsBookmark) async {
    bool isSucceed = false; // 是否执行成功
    if (oldIsBookmark) {
      isSucceed = await ApiIllusts().deleteIllustBookmark(illustId: id);
    } else {
      isSucceed = await ApiIllusts().addIllustBookmark(illustId: id);
    }
    // 执行结果
    return isSucceed;
  }

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: const CircularProgressIndicator(strokeWidth: 1.0),
      ),
    );
  }
}
