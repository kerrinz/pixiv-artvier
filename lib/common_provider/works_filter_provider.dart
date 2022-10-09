import 'package:flutter/material.dart';

/// 作品类型，当插画和漫画合并时，以[illust]代替两者作为整体
enum WorksType {
  illust,
  manga,
  novel,
}

/// 展示范围
enum Reveal {
  /// 全部
  all,

  /// 公开的
  public,

  /// 非公开的
  private,
}

class WorksTypeProvider extends ChangeNotifier {
  WorksType currentWorksType;
  Reveal reveal;
  String? tag;

  WorksTypeProvider({
    this.currentWorksType = WorksType.illust,
    this.reveal = Reveal.all,
    this.tag,
  });

  void setCurrentWorksType(WorksType type) {
    currentWorksType = type;
    notifyListeners();
  }
}
