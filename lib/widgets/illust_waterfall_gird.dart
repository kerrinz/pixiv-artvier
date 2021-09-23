import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'illust_waterfall_card.dart';

class IllustWaterfallGird extends StatefulWidget {
  final List<CommonIllust> artworkList; // 图片含基本信息的列表
  final Function onLazyLoad; // 触发懒加载（加载更多）的时候调用
  final int? limit; // 列表项的极限数量，为空则表示不限
  ScrollController? scrollController;
  ScrollPhysics? physics;

  IllustWaterfallGird(
      {Key? key, required this.artworkList, required this.onLazyLoad, this.limit, this.scrollController, this.physics})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new IllustWaterfallGirdState();
}

class IllustWaterfallGirdState extends State<IllustWaterfallGird> {
  @override
  Widget build(BuildContext context) {
    return WaterfallFlow.builder(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      controller: widget.scrollController,
      physics: widget.physics,
      itemCount: widget.artworkList.length,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        collectGarbage: (List<int> garbages) {
          // print('collect garbage : $garbages');
          garbages.forEach((index) {
            final provider = CachedNetworkImageProvider(
              widget.artworkList[index].imageUrls.medium,
            );
            provider.evict();
          });
        },
        viewportBuilder: (int firstIndex, int lastIndex) {
          // print('viewport : [$firstIndex,$lastIndex]');
        },
      ),
      itemBuilder: (BuildContext context, int index) => _buildItem(context, index),
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
    return IllustWaterfallCard(illust: widget.artworkList[index]);
  }

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(strokeWidth: 1.0),
    );
  }
}
