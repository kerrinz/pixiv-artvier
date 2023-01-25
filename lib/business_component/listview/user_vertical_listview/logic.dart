import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/model/following_state_changed_arguments%20copy/following_state_changed_arguments.dart';
import 'package:pixgem/global/provider/follow_state_provider.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/routes.dart';

mixin UserVerticalListViewLogic {
  WidgetRef get ref;

  void handleTapItem(CommonUserPreviews user) {
    Navigator.of(ref.context).pushNamed(
      RouteNames.userDetail.name,
      arguments: PreloadUserLeastInfo(user.user.id.toString(), user.user.name, user.user.profileImageUrls.medium),
    );
  }
}

mixin UserVerticalListViewItemLogic {
  late UserFollowState followState;

  late String userId;

  WidgetRef get ref;

  late final followStateProvider = StateNotifierProvider.autoDispose<FollowNotifier, UserFollowState>((ref) {
    // 监听全局美术作品收藏状态通知器的变化
    ref.listen<FollowingStateChangedArguments?>(globalFollowingStateChangedProvider, (previous, next) {
      if (next != null && next.userId == userId) {
        ref.notifier.setFollowState(next.state);
      }
    });
    return FollowNotifier(followState, ref: ref, userId: userId);
  });

  // TODO: 未使用的方法
  void handleTapFollowButton() {
    var state = ref.read(followStateProvider);
    if (state == CollectState.notCollect) {
      // 当前未关注，添加关注
      ref.read(followStateProvider.notifier).follow(restrict: Restrict.public);
    }
    if (state == CollectState.collected) {
      // 当前已关注，移除关注
      ref.read(followStateProvider.notifier).unfollow();
    }
  }
}