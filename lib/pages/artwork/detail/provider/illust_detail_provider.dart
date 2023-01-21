import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/base/base_api.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

/// 插画详细信息
/// - 若页面已经传递了详细信息，则不会通过这里获取
final illustDetailProvider = FutureProvider.autoDispose.family<CommonIllust?, String>((ref, illustId) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  var res = await ApiIllusts(ref.read(httpRequesterProvider)).illustDetail(illustId);
  return res;
});
