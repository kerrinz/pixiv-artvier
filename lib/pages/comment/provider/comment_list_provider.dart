import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';

/// 评论列表
/// arg: 作品ID
final commentListProvider = AsyncNotifierProvider.autoDispose.family<CommentsNotifier, List<Comments>, String>(() {
  return CommentsNotifier();
});

class CommentsNotifier extends BaseAutoDisposeFamilyAsyncNotifier<List<Comments>, String> {
  late String worksId;

  String? nextUrl;

  final CancelToken _cancelToken = CancelToken();

  /// Request send comment or reply comment.
  ///
  /// Is reply if [state.parentCommentId] not null.
  /// Else is send to works.
  Future<Comments> handleSendOrReply({required int? parentCommentId, String? message, int? stampId}) async {
    assert(message != null || stampId != null);
    var result = await ApiIllusts(requester)
        .sendComment(illustId: worksId, comment: message, stampId: stampId, parentCommentId: parentCommentId);
    // Inset comment.
    if (parentCommentId != null) {
      insetReply(parentCommentId, result.comment);
    } else {
      insetFirst(result.comment);
    }
    return result.comment;
  }

  /// Request delete comment
  Future<bool> handleDelete(int commentId) async {
    var result = await ApiIllusts(requester).deleteComment(commentId: commentId);
    if (!result) return result;

    // Remove comment.
    remove(commentId);

    return result;
  }

  @override
  FutureOr<List<Comments>> build(String arg) async {
    worksId = arg;
    ref.onDispose(() {
      if (_cancelToken.isCancelled) _cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<Comments>> fetch() async {
    var result = await ApiIllusts(requester).getIllustComments(worksId);
    nextUrl = result.nextUrl;
    return result.comments;
  }

  /// 下一页
  /// return bool of hasMore
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiIllusts(requester).nextIllustComments(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.comments));
    return nextUrl != null;
  }

  @override
  Future<void> reload() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  void remove(int commentId) async {
    if (state.value != null) {
      state.value!.removeWhere((comment) => comment.id == commentId);
      state = AsyncValue.data(state.value!);
    }
  }

  void updateCacheReplies(int commentId, IllustComments? reply) {
    final findCommentIndex = state.value!.indexWhere((comment) => comment.id == commentId);
    state.value![findCommentIndex].cacheReplies = reply;
    state = AsyncValue.data(state.value!);
  }

  /// 设置某个评论是否有回复以及回复列表
  void setReply(int parentCommentId, {required bool hasReplies, IllustComments? cacheReplies}) async {
    if (state.value != null) {
      final findCommentIndex = state.value!.indexWhere((comment) => comment.id == parentCommentId);
      state.value![findCommentIndex].hasReplies = hasReplies;
      if (cacheReplies != null) state.value![findCommentIndex].cacheReplies = cacheReplies;
      state = AsyncValue.data(state.value!);
    }
  }

  /// Inset a reply comment to comment.
  /// Will inset first.
  void insetReply(int parentCommentId, Comments comment) async {
    if (state.value != null) {
      final findCommentIndex = state.value!.indexWhere((comment) => comment.id == parentCommentId);
      state.value![findCommentIndex].hasReplies = true;
      final cacheReplies = state.value![findCommentIndex].cacheReplies;
      if (cacheReplies != null) {
        state.value![findCommentIndex].cacheReplies!.comments.insert(0, comment);
      } else {
        state.value![findCommentIndex].cacheReplies = IllustComments([comment], null);
      }
      state = AsyncValue.data(state.value!);
    }
  }

  // Remove a reply comment
  void removeReply(int commentId, int parentCommentId) async {
    final findCommentIndex = state.value!.indexWhere((comment) => comment.id == parentCommentId);
    state.value![findCommentIndex].cacheReplies?.comments.removeWhere((element) => element.id == commentId);
    if ((state.value![findCommentIndex].cacheReplies?.comments.length ?? 0) == 0) {
      state.value![findCommentIndex].hasReplies = false;
    }
    state = AsyncValue.data(state.value!);
  }

  void insetFirst(Comments comment) async {
    if (state.value != null) {
      state.value!.insert(0, comment);
      state = AsyncValue.data(state.value!);
    }
  }

  @override
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}
