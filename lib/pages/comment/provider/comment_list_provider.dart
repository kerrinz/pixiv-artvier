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
