import 'dart:async';

import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/model/marker_state_changed_arguments/marker_state_changed_arguments.dart';
import 'package:artvier/global/model/novel_viewer/novel_viewer_settings_model.dart';
import 'package:artvier/global/provider/novel_marker_provider.dart';
import 'package:artvier/global/provider/requester_provider.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/model_response/novels/novel_detail.dart';
import 'package:artvier/storage/novel_viewer_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 小说详细信息
final novelDetailProvider = FutureProvider.autoDispose.family<NovelDetail?, String>((ref, novelId) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  var res = await ApiNovels(ref.read(httpRequesterProvider)).novelDetail(novelId);
  return res;
});

/// 小说详细信息(WebView)
final novelWebViewDetailProvider =
    AsyncNotifierProvider.autoDispose.family<NovelWebViewDetailNotifier, NovelDetailWebView, String>(() {
  return NovelWebViewDetailNotifier();
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

class NovelWebViewDetailNotifier extends BaseAutoDisposeFamilyAsyncNotifier<NovelDetailWebView, String>
    with BaseAsyncNotifierMixin<NovelDetailWebView> {
  String get novelId => arg;
  final cancelToken = CancelToken();

  @override
  FutureOr<NovelDetailWebView> build(String arg) async {
    // 监听全局收藏状态的变化，更新书签状态
    ref.listen<MarkerStateChangedArguments?>(globalNovelMarkerStateChangedProvider, (previous, next) {
      final value = state.valueOrNull;
      if (next != null && value != null && value.novel.id == next.worksId) {
        state = AsyncValue.data(value.copyWith(
            novel: value.novel.copyWith(marker: next.page != null ? NovelWebViewNovelMarker(page: next.page!) : null)));
      }
    });
    ref.onCancel(() {
      if (!cancelToken.isCancelled) cancelToken.cancel();
    });
    return fetch();
  }

  @override
  Future<NovelDetailWebView> fetch() async {
    return await ApiNovels(ref.read(httpRequesterProvider)).novelDetailWebView(novelId);
  }

  /// 添加书签，page >= 1
  Future<bool> marker(int page) async {
    return await ApiNovels(ref.read(httpRequesterProvider)).markerNovel(novelId: novelId, page: page);
  }

  /// 移除书签
  Future<bool> unmarker() async {
    return await ApiNovels(ref.read(httpRequesterProvider)).unmarkerNovel(novelId: novelId);
  }
}

class NovelViewerSettingsNotifier extends BaseStateNotifier<NovelViewerSettingsModel> {
  NovelViewerSettingsNotifier(super.state, {required super.ref});

  Future<bool> changeTextSize(double textSize) async {
    double formatTextSize = textSize;
    if (textSize < 10) {
      formatTextSize = 10;
    }
    if (textSize > 30) {
      formatTextSize = 30;
    }
    state = state.copyWith(textSize: formatTextSize);
    var storage = NovelViewerStorage(prefs);
    final result = await storage.setTextSize(formatTextSize);
    return result;
  }

  Future<bool> plusTextSize() async {
    final textSize = state.textSize + 1;
    return changeTextSize(textSize);
  }

  Future<bool> minusTextSize() async {
    final textSize = state.textSize - 1;
    return changeTextSize(textSize);
  }
}
