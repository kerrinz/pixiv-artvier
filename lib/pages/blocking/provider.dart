import 'package:artvier/api_app/api_blocking.dart';
import 'package:artvier/global/provider/requester_provider.dart';
import 'package:artvier/model_response/blocking/blocking_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 屏蔽列表
final blockingListProvider = FutureProvider.autoDispose<BlockingListResponse>((ref) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  final response = await ApiBlocking(ref.read(httpRequesterProvider)).blockingList(cancelToken: cancelToken);
  return response;
});
