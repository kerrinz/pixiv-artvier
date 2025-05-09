import 'dart:async';

import 'package:artvier/pages/comment/provider/comment_list_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';

/// 评论回复列表
/// arg: 评论ID
// final commentRepliesProvider = AsyncNotifierProvider.autoDispose.family<CommentsRepliesNotifier, List<Comments>, int>(() {
//   return CommentsRepliesNotifier();
// });

class CommentsRepliesNotifier extends BaseAutoDisposeFamilyAsyncNotifier<List<Comments>, int> {
  late int commentId;

  String? nextUrl;

  final String worksId;

  final CancelToken _cancelToken = CancelToken();

  List<Comments>? initList;

  CommentsRepliesNotifier({this.initList, required this.worksId});

  /// Request send comment or reply comment.
  ///
  /// Is reply if [parentCommentId] not null.
  /// Else is send to works.
  Future<Comments> handleSendOrReply({required int parentCommentId, String? message, int? stampId}) async {
    assert(message != null || stampId != null);
    var result = await ApiIllusts(requester)
        .sendComment(illustId: worksId, comment: message, stampId: stampId, parentCommentId: parentCommentId);
    // Inset comment.
    insetFirst(result.comment);
    // ref.read(commentListProvider(worksId).notifier).insetReply(parentCommentId, result.comment);
    return result.comment;
  }

  /// Request delete comment
  Future<bool> handleDelete(int commentId, int parentCommentId) async {
    var result = await ApiIllusts(requester).deleteComment(commentId: commentId);
    if (!result) return result;

    final commentListNotifier = ref.read(commentListProvider(worksId).notifier);
    remove(commentId);
    commentListNotifier.removeReply(commentId, parentCommentId);

    return result;
  }

  void updateCacheReplies() {
    if (state.valueOrNull != null) {
      ref
          .read(commentListProvider(worksId).notifier)
          .updateCacheReplies(commentId, IllustComments(state.valueOrNull!, nextUrl));
    }
  }

  @override
  FutureOr<List<Comments>> build(int arg) async {
    commentId = arg;
    ref.onDispose(() {
      if (_cancelToken.isCancelled) _cancelToken.cancel();
    });
    return fetch();
  }

  @override
  Future<List<Comments>> fetch() async {
    var result = await ApiIllusts(requester).commentReplies(commentId);
    nextUrl = result.nextUrl;
    ref
        .read(commentListProvider(worksId).notifier)
        .setReply(commentId, hasReplies: result.comments.isNotEmpty, cacheReplies: result);
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

  List<Comments> remove(int commentId) {
    if (state.value != null) {
      state.value!.removeWhere((comment) => comment.id == commentId);
      state = AsyncValue.data(state.value!);
    }
    return state.value!;
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
