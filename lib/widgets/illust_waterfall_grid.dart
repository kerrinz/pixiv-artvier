import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artworks/artworks_detail_page.dart';
import 'package:pixgem/request/api_illusts.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'illust_waterfall_card.dart';

class IllustWaterfallGrid extends StatefulWidget {
  final List<CommonIllust> artworkList; // 图片含基本信息的列表
  final Function onLazyLoad; // 触发懒加载（加载更多）的时候调用
  final int? limit; // 列表项的极限数量，为空则表示不限
  final ScrollController? scrollController;
  final ScrollPhysics? physics;

  IllustWaterfallGrid(
      {Key? key, required this.artworkList, required this.onLazyLoad, this.limit, this.scrollController, this.physics})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new IllustWaterfallGridState();
}

class IllustWaterfallGridState extends State<IllustWaterfallGrid> {
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
    if (index == widget.artworkList.length) {
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
    return IllustWaterfallCard(
      illust: widget.artworkList[index],
      onTap: () => Navigator.of(context).pushNamed("artworks_detail",
          arguments: ArtworkDetailModel(
              list: widget.artworkList,
              index: index,
              callback: (int index, bool isBookmarked) {
                widget.artworkList[index].isBookmarked = isBookmarked;
                setState(() {});
              })),
      isBookmarked: widget.artworkList[index].isBookmarked,
      onTapBookmark: () {
        var item = widget.artworkList[index];
        postBookmark(item.id.toString(), item.isBookmarked).then((value) {
          Fluttertoast.showToast(msg: "操作成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
          widget.artworkList[index].isBookmarked = !item.isBookmarked;
          setState(() {});
        }).onError((error, stackTrace) {
          Fluttertoast.showToast(msg: "操作失败！$error", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        });
      },
    );
  }

  /* 收藏或者取消收藏插画 */
  Future<bool> postBookmark(String id, bool oldIsBookmark) async {
    bool isSucceed = false; // 是否执行成功
    if (oldIsBookmark)
      isSucceed = await ApiIllusts().deleteIllustBookmark(illustId: id);
    else
      isSucceed = await ApiIllusts().addIllustBookmark(illustId: id);
    // 执行结果
    if (isSucceed)
      return true;
    else {
      Future.error("Request bookmark failed!");
      return false;
    }
  }

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(strokeWidth: 1.0),
    );
  }
}
