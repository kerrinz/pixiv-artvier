import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class PicListGird extends StatefulWidget {
  final List<CommonIllust> artworkList; // 图片含基本信息的列表
  final Function onLazyLoad; // 触发懒加载（加载更多）的时候调用
  final int? limit; // 列表项的极限数量，为空则表示不限

  PicListGird({Key? key, required this.artworkList, required this.onLazyLoad, this.limit}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new PicListGirdState();
}

class PicListGirdState extends State<PicListGird> {
  @override
  Widget build(BuildContext context) {
    // return GridView.builder(
    //   shrinkWrap: true,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisSpacing: 4.0, mainAxisSpacing: 4.0, crossAxisCount: 2, childAspectRatio: 1.0),
    //   itemCount: widget.artworkList.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     // 如果滑动到了表尾
    //     if (index == widget.artworkList.length - 1) {
    //       // 未到列表上限，继续获取数据
    //       if (widget.artworkList.length < (widget.limit ?? double.infinity)) {
    //         if (widget.artworkList.length > 0) widget.onLazyLoad(); // 列表不为空才获取数据
    //         //加载时显示loading
    //         return Container(
    //           padding: const EdgeInsets.all(16.0),
    //           alignment: Alignment.center,
    //           child: SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(strokeWidth: 2.0)),
    //         );
    //       } else {
    //         //已经加载足够多的数据，不再获取
    //         return Container(
    //             alignment: Alignment.center,
    //             padding: EdgeInsets.all(16.0),
    //             child: Text(
    //               "没有更多了",
    //               style: TextStyle(color: Colors.grey),
    //             ));
    //       }
    //     }
    //     // 非表尾的情况下显示列表项
    //     return GestureDetector(
    //       onTap: () {
    //         // 点击事件
    //         // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //         //   return ArtWorksDetailPage(illustId: widget.artworkList[index].id);
    //         // }));
    //         Navigator.of(context).pushNamed("artworks_detail", arguments: widget.artworkList[index]);
    //       },
    //       child: Stack(
    //         fit: StackFit.expand,
    //         children: [
    //           Container(
    //               child: Image(
    //                 image: NetworkImage(
    //                   widget.artworkList[index].imageUrls.medium,
    //                   headers: {"Referer": CONSTANTS.referer},
    //                 ),
    //                 fit: BoxFit.cover,
    //                 // 加载时显示loading图标
    //                 loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    //                   if (loadingProgress == null) return child;
    //                   return _buildLoading(context);
    //                 },
    //               )),
    //           // 收藏按钮
    //           Positioned(
    //             right: 4,
    //             bottom: 4,
    //             child: Builder(
    //               builder: (context) {
    //                 if (widget.artworkList[index].isBookmarked) {
    //                   return Icon(Icons.favorite, color: Colors.red.shade600, size: 32);
    //                 }
    //                 return Icon(
    //                   Icons.favorite_rounded,
    //                   color: Colors.grey,
    //                   size: 32,
    //                 );
    //               },
    //             ),
    //           )
    //         ],
    //       ),
    //     );
    //   },
    // );
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      itemCount: widget.artworkList.length,
      itemBuilder: (context, index) {
        // 如果滑动到了表尾
        if (index == widget.artworkList.length - 1) {
          // 未到列表上限，继续获取数据
          if (widget.artworkList.length < (widget.limit ?? double.infinity)) {
            if (widget.artworkList.length > 0) widget.onLazyLoad(); // 列表不为空才获取数据
            //加载时显示loading
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(strokeWidth: 2.0)),
            );
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
        return Card(
          elevation: 2.0,
          shadowColor: Colors.grey.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                child: CachedNetworkImage(
                  imageUrl: widget.artworkList[index].imageUrls.medium,
                  httpHeaders: {"Referer": CONSTANTS.referer},
                  // progressIndicatorBuilder: (context, url, process) {
                  //   return _buildLoading(context);
                  // },
                ),
              ),
              // 收藏按钮
              Positioned(
                right: 4,
                bottom: 4,
                child: Builder(
                  builder: (context) {
                    if (widget.artworkList[index].isBookmarked) {
                      return Icon(Icons.favorite, color: Colors.red.shade600, size: 32);
                    }
                    return Icon(
                      Icons.favorite_rounded,
                      color: Colors.grey,
                      size: 32,
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.black12.withOpacity(0.15),
                    highlightColor: Colors.black12.withOpacity(0.1),
                    onTap: () {
                      Navigator.of(context).pushNamed("artworks_detail", arguments: widget.artworkList[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
      staggeredTileBuilder: (index) {
        var item = widget.artworkList[index];
        return StaggeredTile.count(1, item.height / item.width); //第一个参数是横轴所占的单元数，第二个参数是主轴所占的单元数
      },
      shrinkWrap: true,
      // mainAxisSpacing: 5.0,
      // crossAxisSpacing: 5.0,
    );
  }

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(strokeWidth: 1.0),
    );
  }
}
