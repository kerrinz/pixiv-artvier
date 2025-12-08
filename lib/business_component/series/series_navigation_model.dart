import 'package:artvier/config/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'series_navigation_model.freezed.dart';

/// 系列作品的导航的状态
@Freezed(
  copyWith: true,
)
class SeriesNavigationModel with _$SeriesNavigationModel {
  const factory SeriesNavigationModel({
    required bool seriesIsWatched,
    required LoadState loadstate,
  }) = _SeriesNavigationModel;
}
