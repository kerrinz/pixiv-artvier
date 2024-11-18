import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/global/provider/requester_provider.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/model_response/novels/novel_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 小说详细信息
final novelDetailProvider = FutureProvider.autoDispose.family<NovelDetail?, String>((ref, illustId) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  var res = await ApiNovels(ref.read(httpRequesterProvider)).novelDetail(illustId);
  return res;
});

/// 小说详细信息(WebView)
final novelDetailWebViewProvider = FutureProvider.autoDispose.family<NovelDetailWebView?, String>((ref, illustId) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  var res = await ApiNovels(ref.read(httpRequesterProvider)).novelDetailWebView(illustId);
  return res;
});
