import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_bar_model.freezed.dart';

/// 图片多种画质的链接
@Freezed(
  copyWith: true,
)
class CommentBarModel with _$CommentBarModel {
  const factory CommentBarModel({
    /// 回复哪个评论
    int? parentCommentId,
    String? parentCommentName,

    /// 是否正在发布中
    @Default(false) bool isSending,

    /// 是否处于激活状态
    @Default(false) bool isActived,

    /// 输入框的内容
    String? comment,
  }) = _CommentBarModel;
}
