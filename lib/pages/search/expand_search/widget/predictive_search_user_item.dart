import 'package:artvier/business_component/button/user_follow_button.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/following_state_changed_arguments%20copy/following_state_changed_arguments.dart';
import 'package:artvier/global/provider/follow_state_provider.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 预测搜索，用户卡片
class PredictiveSearchUserItem extends ConsumerStatefulWidget {
  const PredictiveSearchUserItem({
    super.key,
    required this.user,
    required this.onTap,
  });

  final CommonUserPreviews user;

  /// 点击卡片的事件
  final VoidCallback onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PredictiveSearchUserItemState();
}

class _PredictiveSearchUserItemState extends ConsumerState<PredictiveSearchUserItem> {
  String get userId => userData.user.id.toString();

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  CommonUserPreviews get userData => widget.user;

  late final userFollowProvider = StateNotifierProvider<FollowNotifier, UserFollowState>((ref) {
    final followState = (widget.user.user.isFollowed ?? false) ? UserFollowState.followed : UserFollowState.notFollow;
    return FollowNotifier(followState, ref: ref, userId: userId);
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 监听全局变化
    ref.listen<FollowingStateChangedArguments?>(globalFollowingStateChangedProvider, (previous, next) {
      if (next != null && next.userId == widget.user.user.id.toString()) {
        ref.read(userFollowProvider.notifier).update(next.state);
      }
    });
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    child: ClipOval(
                      child: EnhanceNetworkImage(
                        image: ExtendedNetworkImageProvider(
                          HttpHostOverrides().pxImgUrl(userData.user.profileImageUrls.medium),
                          headers: HttpHostOverrides().pximgHeaders,
                          cache: true,
                        ),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(userData.user.name),
                    ),
                  ),
                  UserFollowButtonStateless(
                    followState: ref.watch(userFollowProvider),
                    userId: userId,
                    requestFollow: ref.read(userFollowProvider.notifier).follow,
                    requestUnfollow: ref.read(userFollowProvider.notifier).unfollow,
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
