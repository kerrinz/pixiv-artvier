import 'package:freezed_annotation/freezed_annotation.dart';

part 'pixivision_webview_page_arguments.freezed.dart';

/// Pixivision Webview 页的传递参数
@Freezed(
  copyWith: true,
)
class PixivisionWebViewPageArguments with _$PixivisionWebViewPageArguments {
  const factory PixivisionWebViewPageArguments({
    /// 语言
    required String language,
    /// ID
    required int id,
    /// 作品标题
    required String title,
    /// 作品封面图链接
    required String coverUrl,
  }) = _PixivisionWebViewPageArguments;
}
