import 'dart:async';

import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_listview_provider.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:artvier/pages/comment/model/comment_bar_model.dart';
import 'package:artvier/pages/comment/provider/comment_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';

final commentBarProvider =
    StateNotifierProvider.autoDispose.family<CommentBarNotifier, CommentBarModel, String>((ref, worksId) {
  return CommentBarNotifier(const CommentBarModel(), ref: ref, worksId: worksId);
});

/// Default send mode: [model.parentCommentId] is null.
/// Reply mode: [model.parentCommentId] is not null.
class CommentBarNotifier extends BaseStateNotifier<CommentBarModel> {
  CommentBarNotifier(super.state, {required super.ref, required this.worksId});

  String worksId;

  /// Send comment or reply comment.
  ///
  /// Is reply if [state.parentCommentId] not null.
  /// Else is send to works.
  Future<Comments> sendOrReply({String? comment, int? stampId, CommentsRepliesNotifier? repliesNotifier}) async {
    assert(comment != null || stampId != null);
    update(state.copyWith(isSending: true));
    var result = await ApiIllusts(requester)
        .sendComment(illustId: worksId, comment: comment, stampId: stampId, parentCommentId: state.parentCommentId)
        .whenComplete(() => update(state.copyWith(isSending: false)));
    // Inset comment.
    if (state.parentCommentId != null) {
      if (repliesNotifier != null) {
        repliesNotifier.insetFirst(result.comment);
      }
    } else {
      ref.read(commentListProvider(worksId).notifier).insetFirst(result.comment);
    }
    return result.comment;
  }

  Future<bool> delete(int commentId, {int? parentCommentId, CommentsRepliesNotifier? repliesNotifier}) async {
    final parentId = parentCommentId ?? state.parentCommentId;
    var result = await ApiIllusts(requester).deleteComment(commentId: commentId);
    if (!result) return result;
    if (repliesNotifier != null && parentId != null) {
      final list = repliesNotifier.remove(commentId);
      if (list.isEmpty) {
        // If delete last comment.
        ref.read(commentListProvider(worksId).notifier).setReply(parentId, hasReplies: false);
      }
    } else {
      ref.read(commentListProvider(worksId).notifier).remove(commentId);
    }
    return result;
  }

  Future<void> enableReply(int parentCommentId, String parentCommentName) async {
    state = state.copyWith(parentCommentId: parentCommentId, parentCommentName: parentCommentName);
  }

  Future<void> disableReply() async {
    state = state.copyWith(parentCommentId: null, parentCommentName: null);
  }

  Future<void> activeWidget() async {
    state = state.copyWith(isActived: true);
  }

  Future<void> unactiveWidget() async {
    state = state.copyWith(isActived: false);
  }
}
