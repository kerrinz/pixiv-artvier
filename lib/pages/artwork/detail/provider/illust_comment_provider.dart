import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_api.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';

/// 请求获取的预览版评论列表
final commentsPreviewProvider = FutureProvider.autoDispose.family<List<Comments>, String>((ref, illustId) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  final response =
      await ApiIllusts(ref.read(httpRequesterProvider)).getIllustComments(illustId, cancelToken: cancelToken);
  return response.comments;
});
