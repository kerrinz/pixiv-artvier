import 'package:freezed_annotation/freezed_annotation.dart';

part 'pixivision_body_illust_item.freezed.dart';

/// Pixivision Webview 页的传递参数
@Freezed(
  copyWith: true,
)
class PixivisionBodyIllustItem with _$PixivisionBodyIllustItem {
  const factory PixivisionBodyIllustItem({
    /// 作品名
    required String illustTitle,

    /// 作品ID
    required String illustId,

    /// 图片地址
    required String illustUrl,

    /// 作者名
    required String authorName,

    /// 作者头像
    required String authorAvatar,

    /// 作者Id
    required String authorId,

    /// 作品描述
    required List<String>? description,
  }) = _PixivisionBodyIllustItem;
}
