import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_listview_item.dart';
import 'package:artvier/business_component/listview/lazyload_logic_mixin.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';

typedef CommentReplyCallback = void Function(int commentId, String commentName);
typedef CommentDeleteCallback = void Function(int commentId);

class CommentRepliesListView extends ConsumerWidget with LazyloadLogic {
  final List<Comments> commentList;

  @override
  final Future<bool> Function() onLazyload;

  final LazyloadState? lazyloadState;

  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  final String worksId;

  final CommentReplyCallback? onReply;
  final CommentDeleteCallback? onDelete;

  late final WidgetRef ref;
  CommentRepliesListView({
    super.key,
    required this.worksId,
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
      worksId: worksId,
      comment: comment,
      onReply: onReply != null ? () => onReply!(comment.id, comment.user.name) : null,
      onDelete: onDelete != null ? () => onDelete!(comment.id) : null,
      isDetailModal: true,
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

/// See [CommentRepliesListView].
class SliverCommentRepliesListView extends CommentRepliesListView {
  SliverCommentRepliesListView({
    super.key,
    required super.worksId,
    required super.commentList,
    required super.onLazyload,
    super.lazyloadState,
    super.scrollController,
    super.physics,
    super.padding,
    super.onReply,
    super.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => itemBuilder(ref, index),
          childCount: commentList.length + 1,
        ),
      ),
    );
  }
}
