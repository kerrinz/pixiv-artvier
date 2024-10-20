import 'package:artvier/model_response/manga/manga_series_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arguments.freezed.dart';

/// Pixivision Webview 页的传递参数
@Freezed(
  copyWith: true,
)
class MangaSeriesDetailPagePageArguments with _$MangaSeriesDetailPagePageArguments {
  const factory MangaSeriesDetailPagePageArguments({
    /// ID
    required int id,

    /// 作品标题
    required String title,

    /// 封面图
    required String url,

    /// 作者
    required User user,
  }) = _MangaSeriesDetailPagePageArguments;
}
