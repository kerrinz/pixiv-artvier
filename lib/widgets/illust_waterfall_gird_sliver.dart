import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/widgets/illust_waterfall_card.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class IllustWaterfallGirdSliver extends StatefulWidget {
  final List<CommonIllust> artworkList; // 图片含基本信息的列表
  final Function onLazyLoad; // 触发懒加载（加载更多）的时候调用
  final int? limit; // 列表项的极限数量，为空则表示不限
  ScrollPhysics? physics;

  IllustWaterfallGirdSliver({Key? key, required this.artworkList, required this.onLazyLoad, this.limit, this.physics})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new IllustWaterfallGirdSliverState();
}

class IllustWaterfallGirdSliverState extends State<IllustWaterfallGirdSliver> with AutomaticKeepAliveClientMixin {
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
    // return NotificationListener(
    //   onNotification: notificationFunction,
    //   child: SliverGrid(
    //     // physics: widget.physics,
    //     // shrinkWrap: true,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisSpacing: 4.0, mainAxisSpacing: 4.0, crossAxisCount: 2, childAspectRatio: 1.0),
    //     // itemCount: widget.artworkList.length,
    //     // itemBuilder: (BuildContext context, int index) {
    //     // },
    //     delegate: SliverChildBuilderDelegate(
    //       (BuildContext context, int index) {
    //         // 如果滑动到了表尾
    //         if (index == widget.artworkList.length - 1) {
    //           // 未到列表上限，继续获取数据
    //           if (widget.artworkList.length < (widget.limit ?? double.infinity)) {
    //             if (widget.artworkList.length > 0) widget.onLazyLoad(); // 列表不为空才获取数据
    //             //加载时显示loading
    //             return Container(
    //               padding: const EdgeInsets.all(16.0),
    //               alignment: Alignment.center,
    //               child: SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(strokeWidth: 2.0)),
    //             );
    //           } else {
    //             //已经加载足够多的数据，不再获取
    //             return Container(
    //                 alignment: Alignment.center,
    //                 padding: EdgeInsets.all(16.0),
    //                 child: Text(
    //                   "没有更多了",
    //                   style: TextStyle(color: Colors.grey),
    //                 ));
    //           }
    //         }
    //         // 非表尾的情况下显示列表项
    //         return GestureDetector(
    //           onTap: () {
    //             // 点击事件
    //             // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //             //   return ArtWorksDetailPage(illustId: widget.artworkList[index].id);
    //             // }));
    //             Navigator.of(context).pushNamed("artworks_detail", arguments: widget.artworkList[index]);
    //           },
    //           child: Stack(
    //             fit: StackFit.expand,
    //             children: [
    //               Container(
    //                   child: CachedNetworkImage(
    //                     imageUrl: widget.artworkList[index].imageUrls.medium,
    //                     httpHeaders: {"Referer": CONSTANTS.referer},
    //                     // progressIndicatorBuilder: (context, url, process) {
    //                     //   return _buildLoading(context);
    //                     // },
    //                   ),),
    //               // 收藏按钮
    //               Positioned(
    //                 right: 4,
    //                 bottom: 4,
    //                 child: Builder(
    //                   builder: (context) {
    //                     if (widget.artworkList[index].isBookmarked) {
    //                       return Icon(Icons.favorite, color: Colors.red.shade600, size: 32);
    //                     }
    //                     return Icon(
    //                       Icons.favorite_rounded,
    //                       color: Colors.grey,
    //                       size: 32,
    //                     );
    //                   },
    //                 ),
    //               )
    //             ],
    //           ),
    //         );
    //       },
    //       childCount: widget.artworkList.length,
    //     ),
    //   ),
    // );
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // crossAxisSpacing: 4,
        // mainAxisSpacing: 4,
        collectGarbage: (List<int> garbages) {
          print('collect garbage : $garbages');
        },
        viewportBuilder: (int firstIndex, int lastIndex) {
          print('viewport : [$firstIndex,$lastIndex]');
        },
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
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
          // 当快速滚动时
          if (isFastScroll) {
            return Card(
              elevation: 2.0,
              shadowColor: Colors.grey.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(),
            );
          }
          return Padding(padding: EdgeInsets.all(4), child: IllustWaterfallCard(illust: widget.artworkList[index]));
        },
        childCount: widget.artworkList.length,
      ),
    );
  }

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 16.0),
      child: CircularProgressIndicator(strokeWidth: 1.0),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
