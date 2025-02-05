import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/image/stack_avatar_list.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/routes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 推荐用户的组件
class RecommendUsersWidget extends BasePage {
  const RecommendUsersWidget({super.key, required this.users});
  final List<CommonUserPreviews> users;
  final avatarSize = 32.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reversedUsers = users.reversed.toList();
    return Material(
      color: colorScheme(context).surface,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(ref.context).pushNamed(RouteNames.recommendUsers.name);
        },
        splashFactory: InkSparkle.splashFactory,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          height: avatarSize + 20,
          child: Row(
            children: [
              Icon(Icons.person_4, color: colorScheme(context).secondary),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(l10n(context).recommendUsers),
              ),
              Expanded(
                child: StackAvatarList(
                  reverse: true,
                  itemWidth: 32,
                  offset: 8,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    final item = reversedUsers[index];
                    return Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.25), width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: ExtendedNetworkImageProvider(
                            HttpHostOverrides().pxImgUrl(item.user.profileImageUrls.medium),
                            headers: HttpHostOverrides().pximgHeaders,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Icon(Icons.keyboard_arrow_right_outlined, color: colorScheme(context).secondary),
            ],
          ),
        ),
      ),
    );
  }
}
