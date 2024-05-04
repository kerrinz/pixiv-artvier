import 'package:artvier/global/logger.dart';
import 'package:artvier/pages/artwork/history/provider/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin HistoryPageLogic {
  WidgetRef get ref;

  /// 清空历史记录
  void handleClearHistory() {
    ref
        .read(viewingHistoryProvider.notifier)
        .clearAll()
        .then((value) => Fluttertoast.showToast(msg: "清空成功"))
        .catchError((err, _) {
      Fluttertoast.showToast(msg: "操作错误");
      logger.e(err);
      return null;
    }).whenComplete(() => Navigator.of(ref.context).pop());
  }
}
