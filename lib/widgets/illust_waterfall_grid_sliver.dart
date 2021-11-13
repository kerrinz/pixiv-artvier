import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/widgets/illust_waterfall_card.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class IllustWaterfallGridSliver extends StatefulWidget {
  final List<CommonIllust> artworkList; // 图片含基本信息的列表
  final Function onLazyLoad; // 触发懒加载（加载更多）的时候调用
  final int? limit; // 列表项的极限数量，为空则表示不限

  IllustWaterfallGridSliver({Key? key, required this.artworkList, required this.onLazyLoad, this.limit})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new IllustWaterfallGridSliverState();
}

class IllustWaterfallGridSliverState extends State<IllustWaterfallGridSliver> {
  bool isFastScroll = false; // 是否处于快速滚动时

  bool notificationFunction(Notification notification) {
    ///通知类型
    switch (notification.runtimeType) {
      case ScrollStartNotification:
        print("开始滚动");

        ///在这里更新标识 刷新页面 不加载图片
        isFastScroll = true;
        break;
      case ScrollUpdateNotification:
        print("正在滚动");
        break;
      case ScrollEndNotification:
        print("滚动停止");

        ///在这里更新标识 刷新页面 加载图片
        setState(() {
          isFastScroll = false;
        });
        break;
      case OverscrollNotification:
        print("滚动到边界");
        break;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // crossAxisSpacing: 4,
        // mainAxisSpacing: 4,
        collectGarbage: (List<int> garbages) {
          // print('collect garbage : $garbages');
          // 内存回收
          int end = garbages.last;
          for (int i = garbages.first; i <= end; i++) {
            final provider = CachedNetworkImageProvider(
              widget.artworkList[i].imageUrls.medium,
            );
            provider.evict();
          }
        },
        viewportBuilder: (int firstIndex, int lastIndex) {
          // print('viewport : [$firstIndex,$lastIndex]');
        },
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => _buildItem(context, index),
        childCount: widget.artworkList.length,
      ),
    );
  }

  Widget _buildItem(BuildContext context, index) {
    // 如果滑动到了表尾
    if (index == widget.artworkList.length - 1) {
      // 未到列表上限，继续获取数据
      if (widget.artworkList.length < (widget.limit ?? double.infinity)) {
        if (widget.artworkList.length > 0) widget.onLazyLoad(); // 列表不为空才获取数据
        //加载时显示loading
        return _buildLoading(context);
      } else {
        //已经加载足够多的数据，不再获取
        return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              "没有更多了",
              style: TextStyle(color: Colors.grey),
            ));
      }
    }
    return Padding(padding: EdgeInsets.all(4), child: IllustWaterfallCard(illust: widget.artworkList[index]));
  }

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 16.0),
      child: CircularProgressIndicator(strokeWidth: 1.0),
    );
  }
}
