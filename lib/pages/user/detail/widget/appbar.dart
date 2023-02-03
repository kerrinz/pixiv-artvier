import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/artwork/detail/widgets/user_follow_button.dart';
import 'package:artvier/pages/user/detail/provider/user_detail_provider.dart';

class UserDetailPageAppBarWidget extends ConsumerWidget {
  const UserDetailPageAppBarWidget({
    super.key,
    required this.userId,
    required this.avatarUrl,
    required this.name,
    required this.backgroundOpacity,
    required this.titleOpacity,
  });

  final String userId;

  final String avatarUrl;

  final String name;

  final double backgroundOpacity;

  final double titleOpacity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double reverseOpacity = 1 - backgroundOpacity; // AppBar背景色透明度的反向透明度
    Color buttonBackground = const Color(0x55000000).withAlpha((85 * reverseOpacity).toInt()); // back和action按钮的背景色
    int c = Theme.of(context).brightness == Brightness.light ? (255 * reverseOpacity).toInt() : 240;
    Color buttonForeground = Color.fromARGB(255, c, c, c);
    return AppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(backgroundOpacity),
      leading: BlurButton(
        onPressed: () {
          Navigator.of(context).pop(-1);
        },
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        padding: const EdgeInsets.all(6.0),
        background: buttonBackground,
        child: Icon(Icons.arrow_back_ios_rounded, size: 20, color: buttonForeground),
      ),
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Opacity(
        opacity: titleOpacity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 头像
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.5), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(80)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                  image: ExtendedNetworkImageProvider(
                    avatarUrl,
                    headers: const {"Referer": CONSTANTS.referer},
                  ),
                ),
              ),
            ),
            // 用户名
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // 关注按钮
            Consumer(
              builder: (_, ref, __) {
                // var followState = ref.watch(userFollowStateProvider(userId));
                var userFollowState = ref.watch(userDetailProvider(userId)).when(
                      data: (data) => data.user.isFollowed ? UserFollowState.followed : UserFollowState.notFollow,
                      error: (error, stackTrace) => null,
                      loading: () => null,
                    );
                if (userFollowState == null) return Container();
                return UserFollowButton(
                  followState: userFollowState,
                  userId: userId,
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        // 菜单按钮
        BlurButton(
          onPressed: () {},
          borderRadius: BorderRadius.circular(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          background: buttonBackground,
          child: Icon(Icons.more_horiz_rounded, color: buttonForeground),
        ),
      ],
    );
  }
}
