import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/component/badge.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';

/// 小说瀑布流对应的列表项
class NovelWaterfallItem extends StatelessWidget {
  final CommonNovel novel;
  final Function onTap; // 点击卡片的事件
  final Function onTapBookmark; // 点击收藏的事件，会自动刷新收藏按钮的UI

  const NovelWaterfallItem({
    Key? key,
    required this.novel,
    required this.onTap,
    required this.onTapBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取到父组件的最大支撑宽度
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxWidth * 0.36;
        return Container(
          width: constraints.maxWidth,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: GestureDetector(
            onTap: () => onTap(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 封面
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: EnhanceNetworkImage(
                    image: ExtendedNetworkImageProvider(
                      novel.imageUrls.medium,
                      headers: const {"Referer": CONSTANTS.referer},
                      cache: true,
                    ),
                    fit: BoxFit.cover,
                    width: constraints.maxWidth * 0.26,
                    height: height,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // height: _height,
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (novel.series.title != null)
                          // 系列
                          Row(
                            children: [
                              Badge(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                color: Colors.amber,
                                child: Text(
                                  LocalizationIntl.of(context).series,
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    novel.series.title ?? "",
                                    style: const TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 小说标题
                            Text(
                              novel.title,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // 其他信息
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  // 作者
                                  const Icon(
                                    Icons.person_outline_rounded,
                                    size: 16,
                                  ),
                                  Text(
                                    novel.user.name,
                                    style: const TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // 标签
                        Builder(builder: (context) {
                          StringBuffer sb = StringBuffer("${novel.textLength.toString()}字 ");
                          for (Tags tag in novel.tags) {
                            sb.write("#");
                            sb.write(tag.name);
                            sb.write(" ");
                          }
                          return Text(
                            sb.toString(),
                            style:
                                TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withAlpha(200)),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                          );
                        }),
                      ],
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
