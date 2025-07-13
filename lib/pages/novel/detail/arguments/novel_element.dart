import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_element.freezed.dart';

enum NovelElementType {
  /// 分页分隔线
  pageDivider,

  /// 章节标题
  chapterTitle,

  /// 内容文本
  text,

  /// 插图
  illust,
}

/// 小说渲染元素的描述
@Freezed(copyWith: true)
class NovelElementModel with _$NovelElementModel {
  const factory NovelElementModel({
    /// 小说渲染元素的类型
    required NovelElementType type,

    GlobalKey? key,

    /// 小说渲染元素
    required dynamic element,
  }) = _NovelElementModel;
}
