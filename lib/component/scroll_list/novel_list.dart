import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/component/scroll_list/novel_list_item.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

/// 小说的瀑布流列表
class NovelList extends StatelessWidget {
  final List<CommonNovel> novelList; // 图片含基本信息的列表
  final Function onLazyLoad; // 触发懒加载（加载更多）的时候调用
  final int? limit; // 列表项的极限数量，为空则表示不限
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool isSliver;

  const NovelList({
    Key? key,
    required this.novelList,
    required this.onLazyLoad,
    this.limit,
    this.scrollController,
    this.physics,
    this.isSliver = false,
    this.padding,
  }) : super(key: key);

  const NovelList.sliver({
    Key? key,
    required this.novelList,
    required this.onLazyLoad,
    this.limit,
    this.scrollController,
    this.physics,
    this.isSliver = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          collectGarbage: (List<int> garbages) {
            // print('collect garbage : $garbages');
            // 内存回收
            int end = garbages.last;
            for (int i = garbages.first; i <= end; i++) {
              final provider = CachedNetworkImageProvider(
                novelList[i].imageUrls.medium,
              );
              provider.evict();
            }
          },
          viewportBuilder: (int firstIndex, int lastIndex) {
            // print('viewport : [$firstIndex,$lastIndex]');
          },
          lastChildLayoutTypeBuilder: (index) =>
              index == novelList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => _buildItem(context, index),
          childCount: novelList.length + 1,
        ),
      );
    }
    return WaterfallFlow.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemCount: novelList.length + 1,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        collectGarbage: (List<int> garbages) {
          // print('collect garbage : $garbages');
          for (var index in garbages) {
            final provider = CachedNetworkImageProvider(
              novelList[index].imageUrls.medium,
            );
            provider.evict();
          }
        },
        viewportBuilder: (int firstIndex, int lastIndex) {
          // print('viewport : [$firstIndex,$lastIndex]');
        },
      ),
      itemBuilder: (BuildContext context, int index) => _buildItem(context, index),
    );
  }

  Widget _buildItem(BuildContext context, index) {
    // 如果滑动到了表尾加载更多的项
    if (index == novelList.length) {
      // 未到列表上限，继续获取数据
      if (novelList.length < (limit ?? double.infinity)) {
        if (novelList.isNotEmpty) onLazyLoad(); // 列表不为空才获取数据
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
    return NovelWaterfallItem(
      novel: novelList[index],
      onTap: () => novelList[index].restrict == 2
          ? Fluttertoast.showToast(msg: "该作品非公开或已被删除", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0)
          : Fluttertoast.showToast(msg: "小说内容还没做呢_(:зゝ∠)_", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0),
      onTapBookmark: () async {
        var item = novelList[index];
        try {
          bool result = await postBookmark(item.id.toString(), item.isBookmarked);
          if (result) {
            Fluttertoast.showToast(msg: "操作成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
            novelList[index].isBookmarked = !item.isBookmarked;
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

  /* 收藏或者取消收藏 */
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
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(strokeWidth: 1.0),
    );
  }
}
