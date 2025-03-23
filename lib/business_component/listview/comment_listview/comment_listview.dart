import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_listview_item.dart';
import 'package:artvier/business_component/listview/comment_listview/logic.dart';
import 'package:artvier/business_component/listview/lazyload_logic_mixin.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';

typedef CommentReplyCallback = void Function(int commentId, String commentName);
typedef CommentDeleteCallback = void Function(int commentId);

/// 插画瀑布流
/// - 默认为非静态组件！
/// - 全权负责管理懒加载的状态，其他状态不在范围内。
/// - 请不要为 [onLazyload] 捕获异常，否则会导致懒加载区域无法显示 errorWidget
class CommentListView extends ConsumerWidget with LazyloadLogic, CommentListViewLogic {
  /// 插画（或漫画）列表
  final List<Comments> commentList;

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

  final CommentReplyCallback? onReply;
  final CommentDeleteCallback? onDelete;

  @override
  late final WidgetRef ref;
  CommentListView({
    super.key,
    required this.commentList,
    required this.onLazyload,
    this.lazyloadState,
    this.scrollController,
    this.physics,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    this.onReply,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    return ListView.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemCount: commentList.length + 1,
      itemBuilder: ((context, index) => itemBuilder(ref, index)),
    );
  }

  Widget itemBuilder(WidgetRef ref, index) {
    // 如果滑动到了表尾加载更多的项
    if (index == commentList.length) {
      handleViewLazyloadWidget(ref, onLazyload);
      // 尾部懒加载组件
      return lazyloadWidget(ref);
    }
    var comment = commentList[index];
    return CommentListViewItem(
      comment: comment,
      onReply: onReply != null ? () => onReply!(comment.id, comment.user.name) : null,
      onDelete: onDelete != null ? () => onDelete!(comment.id) : null,
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

/// See [CommentListView].
class SliverCommentListView extends CommentListView {
  SliverCommentListView({
    super.key,
    required super.commentList,
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
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => itemBuilder(ref, index),
        ),
      ),
    );
  }
}
