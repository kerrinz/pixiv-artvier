import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:artvier/config/enums.dart';

part 'marker_state_changed_arguments.freezed.dart';

/// 小说书签状态发生变化时传递的参数
@Freezed(
  copyWith: true,
)
class MarkerStateChangedArguments with _$MarkerStateChangedArguments {
  const factory MarkerStateChangedArguments({
    required String worksId,

    /// 书签页
    required int? page,
    required MarkerState state,
  }) = _MarkerStateChangedArguments;
}
