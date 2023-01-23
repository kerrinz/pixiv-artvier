import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';

mixin NovelListViewLogic {
  WidgetRef get ref;

  void handleTapItem(CommonNovel novel) {
    Fluttertoast.showToast(msg: "小说阅读功能正在开发中_(:зゝ∠)_", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
  }
}
