import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/model/novel_viewer/novel_viewer_settings_model.dart';
import 'package:artvier/global/provider/requester_provider.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/model_response/novels/novel_detail.dart';
import 'package:artvier/storage/novel_viewer_store.dart';
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
final novelDetailWebViewProvider =
    FutureProvider.autoDispose.family<NovelDetailWebView?, String>((ref, illustId) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  var res = await ApiNovels(ref.read(httpRequesterProvider)).novelDetailWebView(illustId);
  return res;
});

/// 小说阅读器设置
final novelViewerSettings = StateNotifierProvider<NovelViewerSettingsNotifier, NovelViewerSettingsModel>((ref) {
  var prefs = ref.watch(globalSharedPreferencesProvider);
  var storage = NovelViewerStorage(prefs);

  // 从本地读取配置
  final textSize = storage.textSize() ?? 12.0;

  return NovelViewerSettingsNotifier(
    NovelViewerSettingsModel(textSize: textSize),
    ref: ref,
  );
});

class NovelViewerSettingsNotifier extends BaseStateNotifier<NovelViewerSettingsModel> {
  NovelViewerSettingsNotifier(super.state, {required super.ref});

  Future<bool> changeTextSize(double textSize) async {
    state = state.copyWith(textSize: textSize);
    var storage = NovelViewerStorage(prefs);
    final result = await storage.setTextSize(textSize);
    return result;
  }
}
