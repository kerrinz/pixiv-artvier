import 'package:pixgem/model_response/illusts/common_illust.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'artwork_collections_state.freezed.dart';

@freezed
class ArtworkCollectionsState with _$ArtworkCollectionsState {
  /// 加载中
  const factory ArtworkCollectionsState.loading() = _Loading;
  /// 加载完成，但空内容
  const factory ArtworkCollectionsState.empty() = _Empty;
  /// 加载完成，但有内容
  const factory ArtworkCollectionsState.data(List<CommonIllust> artworks) = _Data;
  /// 加载失败
  const factory ArtworkCollectionsState.error(String error) = _Error;
}
