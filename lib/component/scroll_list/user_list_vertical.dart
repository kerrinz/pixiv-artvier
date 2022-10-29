import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/component/loading/lazyloading.dart';
import 'package:pixgem/component/scroll_list/user_list_vertical_item.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

/// 小说的瀑布流列表
class UserVerticalList extends StatelessWidget {
  /// 含预览数据的用户列表
  final List<CommonUserPreviews> userList;
  // 触发懒加载（加载更多）的时候调用
  final Function onLazyLoad;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  /// 主轴（垂直）间距
  final double mainAxisSpacing;
  final bool isSliver;

  /// 是否有更多的数据没请求（即是否还有下一页）; [true] 使懒加载显示Loading，[false] 则显示没有更多数据
  /// - **优先级大于[LazyloadStatusProvider.lazyloadStatus]**
  final bool hasMore;

  const UserVerticalList({
    Key? key,
    required this.userList,
    required this.onLazyLoad,
    this.scrollController,
    this.physics,
    this.isSliver = false,
    this.padding,
    this.hasMore = true,
    this.mainAxisSpacing = 8,
  }) : super(key: key);

  const UserVerticalList.sliver({
    Key? key,
    required this.userList,
    required this.onLazyLoad,
    this.scrollController,
    this.physics,
    this.isSliver = true,
    this.padding,
    this.hasMore = true,
    this.mainAxisSpacing = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: 0,
          collectGarbage: (List<int> garbages) {
            // print('collect garbage : $garbages');
            // 内存回收
            // int end = garbages.last;
            // for (int i = garbages.first; i <= end; i++) {
            //   final provider = CachedNetworkImageProvider(
            //     userList[i].,
            //   );
            //   provider.evict();
            // }
          },
          viewportBuilder: (int firstIndex, int lastIndex) {
            // print('viewport : [$firstIndex,$lastIndex]');
          },
          lastChildLayoutTypeBuilder: (index) =>
              index == userList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => _buildItem(context, index),
          childCount: userList.length + 1,
        ),
      );
    }
    return WaterfallFlow.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemCount: userList.length + 1,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: 0,
        collectGarbage: (List<int> garbages) {
          // print('collect garbage : $garbages');
          // for (var index in garbages) {
          //   final provider = CachedNetworkImageProvider(
          //     userList[index].imageUrls.medium,
          //   );
          //   provider.evict();
          // }
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
    if (index == userList.length) {
      // 未到列表上限，继续获取数据
      if (userList.isNotEmpty) onLazyLoad(); // 列表不为空才获取数据
      // 尾部懒加载组件
      return _buildLazyloadItem(context);
    }
    return UserVerticalListItem(
      user: userList[index],
    );
  }

  Widget _buildLazyloadItem(BuildContext context) {
    return Consumer<LazyloadStatusProvider>(
      builder: ((context, LazyloadStatusProvider provider, child) {
        if (hasMore) {
          switch (provider.lazyloadStatus) {
            case LazyloadStatus.loading:
              return _buildLoading(context);
            case LazyloadStatus.failed:
              return _buildLoadingFailed(context);
          }
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "没有更多了",
              style: TextStyle(color: Colors.grey),
            ),
          );
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
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: const CircularProgressIndicator(strokeWidth: 1.0),
      ),
    );
  }

  // 构建懒加载失败
  Widget _buildLoadingFailed(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: LazyloadingFailedWidget(
          onRetry: () {
            onLazyLoad();
          },
        ),
      ),
    );
  }
}
