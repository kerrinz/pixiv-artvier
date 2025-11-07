import 'package:artvier/business_component/listview/blocking_listview/blocking_user_item.dart';
import 'package:artvier/model_response/blocking/blocking_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/lazyload_logic_mixin.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';

typedef CommentReplyCallback = void Function(int commentId, String commentName);
typedef CommentDeleteCallback = void Function(int commentId);

/// 屏蔽用户列表
class BlockingListView extends ConsumerWidget with LazyloadLogic {
  final List<MutedUser> list;

  /// 编辑模式
  final bool editMode;

  /// 编辑模式下的哪些索引位置已勾选
  final List<int>? checkedList;

  /// 懒加载异步事件
  /// - return bool of hasMore. 需要返回是否还有更多数据
  /// - 当[lazyloadState] = [LazyloadState.loading]/[LazyloadState.noMore] 时**不会执行**此函数
  @override
  final Future<bool> Function()? onLazyload;

  /// 赋值后本组件将不再负责懒加载状态，转变为静态组件
  final LazyloadState? lazyloadState;

  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  final void Function(int index)? onTapItem;
  final void Function(int index)? onTapButton;
  final void Function(int index, bool? value)? onCheckboxChange;

  BlockingListView({
    super.key,
    required this.list,
    this.editMode = false,
    this.checkedList,
    this.onLazyload,
    this.lazyloadState,
    this.scrollController,
    this.physics,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    this.onTapItem,
    this.onTapButton,
    this.onCheckboxChange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemCount: list.length + (onLazyload != null ? 1 : 0),
      itemBuilder: ((context, index) => itemBuilder(ref, index)),
    );
  }

  Widget itemBuilder(WidgetRef ref, index) {
    // 如果滑动到了表尾加载更多的项
    if (onLazyload != null && index == list.length) {
      handleViewLazyloadWidget(ref, onLazyload!);
      // 尾部懒加载组件
      return lazyloadWidget(ref);
    }
    final item = list[index];
    return BlockingUserItem(
      avatar: item.user.profileImageUrls.medium,
      name: item.user.name,
      isBlocked: !(item.user.isAcceptRequest ?? true),
      onTap: onTapItem != null ? () => onTapItem!(index) : null,
      onTapButton: onTapButton != null ? () => onTapButton!(index) : null,
      onCheckboxChange: onCheckboxChange != null ? (bool? value) => onCheckboxChange!(index, value) : null,
      checked: editMode ? (checkedList?.contains(index) ?? false) : null,
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

/// See [BlockingListView].
class SliverBlockingListView extends BlockingListView {
  SliverBlockingListView({
    super.key,
    required super.list,
    super.editMode,
    super.checkedList,
    super.onLazyload,
    super.lazyloadState,
    super.scrollController,
    super.physics,
    super.padding,
    super.onTapButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => itemBuilder(ref, index),
        ),
      ),
    );
  }
}
