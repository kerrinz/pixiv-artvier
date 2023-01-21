import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';

part 'collections_state.freezed.dart';

typedef ArtworkCollectionsState = CollectionsState<List<CommonIllust>>;

typedef NovelCollectionsState = CollectionsState<List<CommonNovel>>;

@freezed
class CollectionsState<Data> with _$CollectionsState<Data> {
  /// 加载中
  const factory CollectionsState.loading() = _Loading;

  /// 加载完成，但空内容
  const factory CollectionsState.empty() = _Empty;

  /// 加载完成，但有内容
  const factory CollectionsState.data(Data data) = _Data;

  /// 加载失败
  const factory CollectionsState.error(String error) = _Error;
}
