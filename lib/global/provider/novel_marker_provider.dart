import 'package:artvier/global/model/marker_state_changed_arguments/marker_state_changed_arguments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/enums.dart';

/// 全局Provider，用于通知小说的书签状态发生改变。
///
/// 使用方式：在其他地方使用`ref.listen()`监听该值的变化
///
/// - Example：
/// ```dart
/// ref.listen<MarkerStateChangedArguments?>(globalNovelMarkerStateChangedProvider, (previous, next) {
///   if (next != null && next.worksId == illustId) {
///     // do change state
///   }
/// });
///  ```

final globalNovelMarkerStateChangedProvider = StateProvider<MarkerStateChangedArguments?>((ref) {
  return null;
});

/// 书签状态
class MarkerStateNotifier extends BaseStateNotifier<MarkerStateChangedArguments> {
  MarkerStateNotifier(
    super.state, {
    required super.ref,
    required this.novelId,
  });

  final String novelId;

  void setMarkerState(MarkerStateChangedArguments newState) {
    state = newState;
  }

  void notifyGlobal(MarkerStateChangedArguments markerState) {
    ref.read(globalNovelMarkerStateChangedProvider.notifier).update((args) => markerState);
  }

  /// 收藏该作品
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> marker({
    required int page,
    bool throwException = true,
  }) async {
    MarkerStateChangedArguments oldState = state;
    MarkerStateChangedArguments newState;
    notifyGlobal(oldState.copyWith(state: MarkerState.addingMarker));
    bool result = false;

    try {
      result = await ApiNovels(requester).markerNovel(novelId: novelId, page: page);
      // 分析结果，取得新的状态
      newState = result ? oldState.copyWith(state: MarkerState.marked, page: page) : oldState;
      if (mounted) {
        state = newState;
      }
      notifyGlobal(newState);
    } catch (e) {
      // 复原收藏状态
      if (mounted) state = oldState;
      notifyGlobal(oldState);
      if (throwException) {
        rethrow;
      }
    }
    return result;
  }

  /// 移除收藏该作品
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> unmarker({
    bool throwException = true,
  }) async {
    MarkerStateChangedArguments oldState = state;
    MarkerStateChangedArguments newState;
    notifyGlobal(oldState.copyWith(state: MarkerState.removingMarker));
    bool result = false;
    try {
      result = await ApiNovels(requester).unmarkerNovel(novelId: novelId);
      // 分析结果，取得新的收藏状态
      newState = result ? oldState.copyWith(state: MarkerState.unmarked) : oldState;
      if (mounted) {
        state = newState;
      }
      notifyGlobal(newState);
    } catch (e) {
      // 复原收藏状态
      if (mounted) state = oldState;
      notifyGlobal(oldState);
      if (throwException) {
        rethrow;
      }
    }
    return result;
  }
}
