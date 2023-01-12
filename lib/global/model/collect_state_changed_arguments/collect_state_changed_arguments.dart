import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgem/config/enums.dart';

part 'collect_state_changed_arguments.freezed.dart';

/// Suitable for illusts, manga, novels.
@Freezed()
class CollectStateChangedArguments with _$CollectStateChangedArguments {
  const factory CollectStateChangedArguments({
    required String worksId,
    required CollectState state,
  }) = _CollectStateChangedArguments;
}
