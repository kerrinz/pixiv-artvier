import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';

/// 收藏状态改变的全局通知触发器
/// 在其他地方使用`ref.listen(illustCollectStateChangedGobalProvider)`监听该值的变化
final globalIllustCollectStateChangedProvider = StateProvider<CollectStateChangedArguments?>((ref) {
  return null;
});

// final globalIllustCollectStateChangedProvider = StateProvider.autoDispose.family<CollectState?, String>((ref, illustId) {
//   return null;
// });
