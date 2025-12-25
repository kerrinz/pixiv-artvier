import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:artvier/config/enums.dart';

part 'series_state_changed_arguments.freezed.dart';

/// 系列作品追更状态发生变化时传递的参数
/// 
/// 插画、漫画、小说均通用
///
/// Suitable for illusts, manga, novels.
@Freezed(
  copyWith: true,
)
class SeriesStateChangedArguments with _$SeriesStateChangedArguments {
  const factory SeriesStateChangedArguments({
    required String seriesId,
    required SeriesState state,
  }) = _SeriesStateChangedArguments;
}
