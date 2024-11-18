import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/lazyload_logic_mixin.dart';
import 'package:artvier/business_component/listview/user_vertical_listview/logic.dart';
import 'package:artvier/business_component/listview/user_vertical_listview/user_vertical_listview_item.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

/// 用户列表
class UserVerticalListView extends ConsumerWidget with LazyloadLogic, UserVerticalListViewLogic {
  /// 含预览数据的用户列表
  final List<CommonUserPreviews> userList;

  /// 懒加载异步事件
  /// - return bool of hasMore. 需要返回是否还有更多数据
  /// - 当[lazyloadState] = [LazyloadState.loading]/[LazyloadState.noMore] 时**不会执行**此函数
  @override
  final Future<bool> Function() onLazyload;

  /// 赋值后本组件将不再负责懒加载状态，转变为静态组件
  final LazyloadState? lazyloadState;

  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  late final WidgetRef ref;

  UserVerticalListView({
    super.key,
    required this.userList,
    required this.onLazyload,
    this.lazyloadState,
    this.crossAxisCount = 1,
    this.mainAxisSpacing = 12,
    this.crossAxisSpacing = 0,
    this.scrollController,
    this.physics,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    return WaterfallFlow.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemCount: userList.length + 1,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        collectGarbage: collectGarbage,
        viewportBuilder: viewportBuilder,
      ),
      itemBuilder: (BuildContext context, int index) => itemBuilder(ref, index),
    );
  }

  void collectGarbage(List<int> garbages) {
    // print('collect garbage : $garbages');
  }

  void viewportBuilder(int firstIndex, int lastIndex) {
    // print('viewport : [$firstIndex,$lastIndex]');
  }

  Widget itemBuilder(WidgetRef ref, index) {
    // 如果滑动到了表尾加载更多的项
    if (index == userList.length) {
      handleViewLazyloadWidget(ref, onLazyload);
      // 尾部懒加载组件
      return lazyloadWidget(ref);
    }
    var user = userList[index];
    return UserVerticalListViewItem(
      user: user,
      followState: (user.user.isFollowed ?? false) ? UserFollowState.followed : UserFollowState.notFollow,
      onTap: () => handleTapItem(user),
    );
  }

  /// 懒加载组件的构建
  Widget lazyloadWidget(WidgetRef ref) => Consumer(
        builder: ((context, ref, _) {
          var lazyloadState = ref.watch(lazyloadStateProvider);
          Map<LazyloadState, Widget> map = {
            LazyloadState.idle: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const CircularProgressIndicator(strokeWidth: 1.0),
            ),
            LazyloadState.loading: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const CircularProgressIndicator(strokeWidth: 1.0),
            ),
            LazyloadState.noMore: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text("没有更多了", style: TextStyle(color: Colors.grey)),
            ),
            LazyloadState.error: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: LazyloadingFailedWidget(
                onRetry: () => handleRetry(ref),
              ),
            ),
          };
          return SafeArea(left: true, top: false, right: true, bottom: true, child: map[lazyloadState]!);
        }),
      );
}

/// See [UserVerticalListView].
class SliverUserVerticalListView extends UserVerticalListView {
  SliverUserVerticalListView({
    super.key,
    required super.userList,
    required super.onLazyload,
    super.lazyloadState,
    super.scrollController,
    super.physics,
    super.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          collectGarbage: collectGarbage,
          viewportBuilder: viewportBuilder,
          lastChildLayoutTypeBuilder: (index) =>
              index == userList.length ? LastChildLayoutType.fullCrossAxisExtent : LastChildLayoutType.none,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => itemBuilder(ref, index),
          childCount: userList.length + 1,
        ),
      ),
    );
  }
}
