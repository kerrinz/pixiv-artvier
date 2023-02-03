import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:artvier/config/enums.dart';

part 'collect_state_changed_arguments.freezed.dart';

/// 作品收藏状态发生变化时传递的参数
/// 
/// 插画、漫画、小说均通用
///
/// Suitable for illusts, manga, novels.
@Freezed(
  copyWith: true,
)
class CollectStateChangedArguments with _$CollectStateChangedArguments {
  const factory CollectStateChangedArguments({
    required String worksId,
    required CollectState state,
  }) = _CollectStateChangedArguments;
}
