import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/model/advanced_collecting_data.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/model_response/common/collection_detail.dart';

/// 全局Provider，用于通知美术作品（插画与漫画）的收藏状态发生改变。
///
/// 使用方式：在其他地方使用`ref.listen()`监听该值的变化
///
/// ---
///
/// The global provider that notifies artwork collection state changes.
///
/// How to use: use `ref.listen()` in other places to listen to the change of the value
///
/// ---
///
/// - Example：
/// ```dart
/// ref.listen<CollectStateChangedArguments?>(globalIllustCollectStateChangedProvider, (previous, next) {
///   if (next != null && next.worksId == illustId) {
///     // do change state
///   }
/// });
///  ```
final globalArtworkCollectionStateChangedProvider = StateProvider<CollectStateChangedArguments?>((ref) {
  return null;
});

/// 与 [globalArtworkCollectionStateChangedProvider] 相似的作用，但仅应用于小说的收藏状态
///
/// Works like [globalArtworkCollectionStateChangedProvider], but only applies to the novel's collection state
final globalNovelCollectionStateChangedProvider = StateProvider<CollectStateChangedArguments?>((ref) {
  return null;
});

/// 收藏状态
class CollectNotifier extends BaseStateNotifier<CollectState> {
  CollectNotifier(
    super.state, {
    required super.ref,
    required this.worksId,
    required this.worksType,
  });

  final String worksId;

  /// 作品类型，小说使用[WorksType.novel]，插画与漫画使用[WorksType.illust]
  final WorksType worksType;

  void setCollectState(CollectState newState) {
    state = newState;
  }

  void notifyGlobal(CollectState collectState) {
    (worksType == WorksType.novel)
        ? ref
            .read(globalNovelCollectionStateChangedProvider.notifier)
            .update((args) => CollectStateChangedArguments(state: collectState, worksId: worksId))
        : ref
            .read(globalArtworkCollectionStateChangedProvider.notifier)
            .update((args) => CollectStateChangedArguments(state: collectState, worksId: worksId));
  }

  /// 收藏该作品
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> collect({
    AdvancedCollectingDataModel? args,
    bool throwException = true,
  }) async {
    CollectState oldState = state;
    CollectState newState;
    notifyGlobal(CollectState.collecting);
    bool result = false;
    var tags = [for (WorksCollectTag item in args?.tags ?? []) item.name!];

    try {
      result = (worksType == WorksType.novel)
          ? await ApiNovels(requester).collectNovel(novelId: worksId, tags: tags, restrict: args?.restrict)
          : await ApiIllusts(requester).collectIllust(illustId: worksId, tags: tags, restrict: args?.restrict);
      // 分析结果，取得新的收藏状态
      newState = result ? CollectState.collected : oldState;
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
  Future<bool> uncollect({
    bool throwException = true,
  }) async {
    CollectState oldState = state;
    CollectState newState;
    notifyGlobal(CollectState.uncollecting);
    bool result = false;
    try {
      result = worksType == WorksType.novel
          ? await ApiNovels(requester).uncollectNovel(novelId: worksId)
          : await ApiIllusts(requester).uncollectIllust(illustId: worksId);
      // 分析结果，取得新的收藏状态
      newState = result ? CollectState.notCollect : oldState;
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
