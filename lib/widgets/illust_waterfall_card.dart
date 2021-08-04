import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class IllustWaterfallCard extends StatefulWidget {
  CommonIllust illust;

  @override
  State<StatefulWidget> createState() => IllustWaterfallCardState();

  IllustWaterfallCard({Key? key, required this.illust}) : super(key: key);
}

class IllustWaterfallCardState extends State<IllustWaterfallCard> {
  @override
  Widget build(BuildContext context) {
    // LayoutBuilder能获取到父组件的最大支撑宽度
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: double.infinity,
          height: (widget.illust.height * constraints.maxWidth) /
              widget.illust.width,
          child: Card(
            elevation: 2.0,
            margin: EdgeInsets.zero,
            shadowColor: Colors.grey.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: widget.illust.width.toDouble(),
                    height: widget.illust.height.toDouble(),
                    imageUrl: widget.illust.imageUrls.medium,
                    httpHeaders: {"Referer": CONSTANTS.referer},
                  ),
                ),
                // 收藏按钮
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Builder(
                    builder: (context) {
                      if (widget.illust.isBookmarked) {
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
                        Navigator.of(context).pushNamed("artworks_detail", arguments: widget.illust);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
