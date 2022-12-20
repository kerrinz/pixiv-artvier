import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/routes.dart';

/// Artwork Page的子页面，展示作品的详情数据
class InfoTabPage extends StatelessWidget {
  final CommonIllust detail;

  const InfoTabPage({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              child: Row(
                children: [
                  // 点赞数
                  Expanded(flex: 1, child: Text("id: ${detail.id}")),
                  // 收藏数
                  Expanded(
                    flex: 1,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.favorite, size: 18, color: Colors.blueGrey.shade300),
                      Text(" ${detail.totalBookmarks}",
                          style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 15, fontWeight: FontWeight.w400)),
                    ]),
                  ),
                  // 浏览数
                  Expanded(
                    flex: 1,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      const Icon(Icons.remove_red_eye, size: 18, color: Colors.grey),
                      Text(" ${detail.totalView}", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    ]),
                  ),
                ],
              )),
          // 简介，字段为comment
          Text(
            detail.caption,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 15),
          ),
          // tags
          Builder(
            builder: (BuildContext context) {
              List<Widget> tags = [];
              // 遍历displayTags
              for (var element in detail.tags) {
                // tag标签
                tags.add(
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: element.name);
                    },
                    child: Text("#${element.name} ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600, fontSize: 15)),
                  ),
                );
                // 标签的翻译文字
                tags.add(
                  Text("${element.translatedName}  "),
                );
              }
              return Wrap(
                children: tags,
              );
            },
          )
        ],
      ),
    );
  }
}
