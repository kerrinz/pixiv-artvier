import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/bottom_sheet/close_bar.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/following_state_changed_arguments%20copy/following_state_changed_arguments.dart';
import 'package:artvier/global/provider/follow_state_provider.dart';
import 'package:artvier/pages/artwork/detail/widgets/user_follow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 用户详情页的菜单
class UserDetailMenu extends BasePage with FollowButtonLogic {
  UserDetailMenu({
    super.key,
    required this.followState,
    required this.userId,
    required this.avatarUrl,
    required this.name,
  });

  late final _userFollowProvider = StateNotifierProvider<FollowNotifier, UserFollowState>((ref) {
    return FollowNotifier(followState, ref: ref, userId: userId);
  });

  @override
  get userFollowProvider => _userFollowProvider;

  final UserFollowState followState;

  final String userId;

  final String avatarUrl;

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<FollowingStateChangedArguments?>(globalFollowingStateChangedProvider, (previous, next) {
      // 监听全局通知
      if (next != null) {
        ref.read(userFollowProvider.notifier).setFollowState(next.state);
      }
    });
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetCloseBar(onTapClose: () => Navigator.of(context).pop()),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 24),
            child: Row(
              children: [
                rowListItem(
                  context: context,
                  text: l10n(context).copyLink,
                  icon: const Icon(Icons.link_rounded),
                  onTap: () => Clipboard.setData(ClipboardData(text: CONSTANTS.referer_users_base + userId.toString()))
                      .then((value) {
                    Fluttertoast.showToast(
                      msg: l10n(context).copiedToClipboard,
                      toastLength: Toast.LENGTH_SHORT,
                      fontSize: 16.0,
                    );
                    Navigator.of(context).pop();
                  }),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    var state = ref.watch(userFollowProvider);
                    String text = l10n(context).privateFollow;
                    if (state == UserFollowState.notFollow || state == UserFollowState.requestingFollow) {
                      text = l10n(context).privateFollow;
                    } else if (state == UserFollowState.followed || state == UserFollowState.requestingUnfollow) {
                      text = l10n(context).cancelFollow;
                    }
                    return rowListItem(
                      context: context,
                      text: text,
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      onTap: () {
                        Navigator.of(context).pop();
                        handlePressed(ref);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rowListItem({required context, required void Function()? onTap, required String text, required Widget icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(12),
              child: icon,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
