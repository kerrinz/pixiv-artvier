import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class IllustWaterfallItem extends StatefulWidget {
  final CommonIllust illust;
  final bool isBookmarked; // 是否被收藏
  final Function onTap; // 点击卡片的事件
  final Function onTapBookmark; // 点击收藏的事件，会自动刷新收藏按钮的UI

  @override
  State<StatefulWidget> createState() => IllustWaterfallItemState();

  const IllustWaterfallItem(
      {Key? key, required this.illust, required this.isBookmarked, required this.onTap, required this.onTapBookmark})
      : super(key: key);
}

class IllustWaterfallItemState extends State<IllustWaterfallItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder能获取到父组件的最大支撑宽度
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = (widget.illust.height.toDouble() * constraints.maxWidth) / widget.illust.width;
        // 最高高度（太高了就阉割掉）
        double maxConstraintHeight = constraints.maxWidth * 3;
        return Card(
          elevation: 8.0,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).colorScheme.secondary.withAlpha(50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: height < maxConstraintHeight ? height : maxConstraintHeight,
                    child: EnhanceNetworkImage(
                      image: ExtendedNetworkImageProvider(
                        widget.illust.imageUrls.medium,
                        cache: true,
                        headers: const {"Referer": CONSTANTS.referer},
                      ),
                      fit: BoxFit.cover,
                      width: widget.illust.width.toDouble(),
                      height: widget.illust.height.toDouble(),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 34.0, top: 4.0),
                              child: Text(
                                widget.illust.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 34.0, bottom: 4.0),
                              child: Text(
                                widget.illust.user.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.black12.withOpacity(0.15),
                    highlightColor: Colors.black12.withOpacity(0.1),
                    onTap: () => widget.onTap(),
                  ),
                ),
              ),
              // 收藏按钮
              Positioned(
                top: height,
                bottom: 0,
                right: 4,
                child: Center(
                  child: Builder(builder: (BuildContext btnContext) {
                    return InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      onTap: () async {
                        await widget.onTapBookmark();
                        (btnContext as Element).markNeedsBuild();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          widget.illust.isBookmarked ? Icons.favorite : Icons.favorite_outline_rounded,
                          color: widget.illust.isBookmarked ? Colors.red.shade600 : Colors.grey,
                          size: 24,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
