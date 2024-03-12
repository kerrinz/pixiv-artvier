import 'package:artvier/model_response/illusts/illust_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_api.dart';

/// 插画详细信息
/// - 若页面已经传递了详细信息，则不会通过这里获取
final illustDetailProvider = FutureProvider.autoDispose.family<IllustDetail?, String>((ref, illustId) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  var res = await ApiIllusts(ref.read(httpRequesterProvider)).illustDetail(illustId);
  return res;
});
