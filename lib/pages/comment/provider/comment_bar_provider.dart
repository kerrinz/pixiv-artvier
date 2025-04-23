import 'dart:async';

import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:artvier/pages/comment/model/comment_bar_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';

final commentBarProvider =
    StateNotifierProvider.autoDispose.family<CommentBarNotifier, CommentBarModel, String>((ref, worksId) {
  return CommentBarNotifier(const CommentBarModel(), ref: ref, worksId: worksId);
});

class CommentBarNotifier extends BaseStateNotifier<CommentBarModel> {
  CommentBarNotifier(super.state, {required super.ref, required this.worksId});

  String worksId;

  Future<Comments> sendOrReply({String? comment, int? stampId}) async {
    assert(comment != null || stampId != null);
    var result = await ApiIllusts(requester)
        .sendComment(illustId: worksId, comment: comment, stampId: stampId, parentCommentId: state.parentCommentId);
    return result.comment;
  }

  Future<bool> delete(int commentId, {int? parentCommentId}) async {
    var result = await ApiIllusts(requester).deleteComment(commentId: commentId);
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
