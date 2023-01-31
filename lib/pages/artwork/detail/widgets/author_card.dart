import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/pages/artwork/detail/widgets/user_follow_button.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/routes.dart';

/// Artworks Detail Page
///
/// 作品的作者卡片
class AuthorCardWidget extends StatelessWidget {
  final CommonIllust detail;

  final TabController tabController;

  const AuthorCardWidget({Key? key, required this.detail, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
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
                  arguments: PreloadUserLeastInfo(
                      detail.user.id.toString(), detail.user.name, detail.user.profileImageUrls.medium));
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
                  UserFollowButton(
                    userId: detail.user.id.toString(),
                    followState:
                        detail.user.isFollowed ?? false ? UserFollowState.followed : UserFollowState.notFollow,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
