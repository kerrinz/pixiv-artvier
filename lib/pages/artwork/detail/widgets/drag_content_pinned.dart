import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/component/bottom_sheet/slide_bar.dart';
import 'package:pixgem/component/buttons/follow_button.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/routes.dart';

/// Artworks Detail Page
///
/// 拖拽抽屉组件缩到最小时显示的内容
class DragContentPinned extends StatelessWidget {
  final CommonIllust detail;

  final TabController tabController;

  const DragContentPinned({Key? key, required this.detail, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: BottomSheetSlideBar(width: 48, height: 3),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
          child:
              FittedBox(child: Text(detail.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          height: 60,
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.userDetail.name,
                      arguments:
                          PreloadUserLeastInfo(detail.user.id, detail.user.name, detail.user.profileImageUrls.medium));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // 作者头像
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipOval(
                          child: EnhanceNetworkImage(
                            image: ExtendedNetworkImageProvider(
                              detail.user.profileImageUrls.medium,
                              headers: const {"Referer": CONSTANTS.referer},
                            ),
                            fit: BoxFit.cover,
                            width: 46,
                            height: 46,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 作者昵称
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                detail.user.name,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colorScheme.primary),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // 发布时间
                            Text(
                              formatDate(DateTime.parse(detail.createDate),
                                  [yyyy, '-', mm, '-', dd, ' ', HH, ':', mm, ':', ss]),
                              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // 关注或已关注的按钮
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                        child: FollowButton(
                          isFollowed: detail.user.isFollowed!,
                          userId: detail.user.id.toString(),
                          followedStyle: FollowButtonStyle(
                            color: colorScheme.primaryContainer,
                            textStyle: TextStyle(color: colorScheme.primary, fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          color: colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TabBar(
            labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            indicatorWeight: 3.0,
            controller: tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: "概述"),
              Tab(text: "评论"),
              Tab(text: "相关推荐"),
            ],
          ),
        ),
      ],
    );
  }
}
