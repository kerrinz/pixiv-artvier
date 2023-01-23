import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/global/provider/shared_preferences_provider.dart';
import 'package:pixgem/pages/artwork/history/provider/history_provider.dart';
import 'package:pixgem/storage/history_storage.dart';

mixin HistoryPageLogic {
  WidgetRef get ref;

  /// 弹窗清空历史记录的确定事件
  void handleClearHistory() {
    HistoryStorage(ref.read(globalSharedPreferencesProvider))
        .clearIllusts()
        .then((value) => ref.invalidate(historyArtworksProvider))
        .catchError((_) => Fluttertoast.showToast(msg: "Error to clear history!"))
        .whenComplete(() => Navigator.of(ref.context).pop());
  }

  /// 列表懒加载触发事件
  Future<bool> handleLazyload() async {
    return false;
  }
}
