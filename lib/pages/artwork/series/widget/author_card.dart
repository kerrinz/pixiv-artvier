import 'package:artvier/model_response/user/common_user.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/artwork/detail/widgets/user_follow_button.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/routes.dart';

/// Manga Series Detail Page
class MangaSeriesAuthorCardWidget extends StatelessWidget {
  final CommonUser user;

  const MangaSeriesAuthorCardWidget({super.key, required this.user});

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
                  arguments: PreloadUserLeastInfo(user.id.toString(), user.name, user.profileImageUrls.medium));
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
                          HttpHostOverrides().pxImgUrl(user.profileImageUrls.medium),
                          headers: HttpHostOverrides().pximgHeaders,
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
                            user.name,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colorScheme.primary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "@${user.account}",
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // 关注或已关注的按钮
                  UserFollowButton(
                    userId: user.id.toString(),
                    followState: (user.isFollowed ?? false) ? UserFollowState.followed : UserFollowState.notFollow,
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
