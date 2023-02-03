import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/common/collection_detail.dart';

part 'advanced_collecting_data.freezed.dart';

@Freezed(
  copyWith: true,
)
class AdvancedCollectingDataModel with _$AdvancedCollectingDataModel {
  factory AdvancedCollectingDataModel({
    required List<WorksCollectTag> tags,
    required Restrict restrict,
    required CollectState collectState,
  }) = _AdvancedCollectingDataModel;
}
