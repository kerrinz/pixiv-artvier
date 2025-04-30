import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/pages/comment/model/comment_bar_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentBarProvider =
    StateNotifierProvider.autoDispose.family<CommentBarNotifier, CommentBarModel, String>((ref, worksId) {
  return CommentBarNotifier(const CommentBarModel(), ref: ref, worksId: worksId);
});

/// Default send mode: [model.parentCommentId] is null.
/// Reply mode: [model.parentCommentId] is not null.
class CommentBarNotifier extends BaseStateNotifier<CommentBarModel> {
  CommentBarNotifier(super.state, {required super.ref, required this.worksId});

  String worksId;

  void setIsSending(bool isSending) {
    update(state.copyWith(isSending: isSending));
  }

  void enableReply(int parentCommentId, String parentCommentName) async {
    state = state.copyWith(parentCommentId: parentCommentId, parentCommentName: parentCommentName);
  }

  void disableReply() async {
    state = state.copyWith(parentCommentId: null, parentCommentName: null);
  }
}
