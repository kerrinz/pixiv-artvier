import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';

/// 高级收藏（插画漫画）
final artworkAdvancedCollectingProvider =
    StateNotifierProvider.autoDispose.family<_AdvancedCollectNotifier, CollectState?, String>((ref, worksId) {
  return _AdvancedCollectNotifier(null, ref: ref, worksId: worksId, worksType: WorksType.illust);
});

/// 高级收藏（小说）
final novelAdvancedCollectingProvider =
    StateNotifierProvider.autoDispose.family<_AdvancedCollectNotifier, CollectState?, String>((ref, worksId) {
  return _AdvancedCollectNotifier(null, ref: ref, worksId: worksId, worksType: WorksType.novel);
});

/// 高级收藏状态
class _AdvancedCollectNotifier extends BaseStateNotifier<CollectState?> {
  _AdvancedCollectNotifier(
    super.state, {
    required super.ref,
    required this.worksId,
    required this.worksType,
  });

  final String worksId;

  /// 作品类型，小说使用[WorksType.novel]，插画与漫画使用[WorksType.illust]
  final WorksType worksType;

  void notifyGlobal(CollectState collectState) {
    ref
        .read((worksType == WorksType.novel)
            ? globalNovelCollectionStateChangedProvider.notifier
            : globalArtworkCollectionStateChangedProvider.notifier)
        .update((args) => CollectStateChangedArguments(state: collectState, worksId: worksId));
  }

  /// 收藏该作品
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> collect({
    // 旧的收藏状态
    required CollectState oldCollectState,
    required List<String> tagNameList,
    required Restrict restrict,
    bool throwException = true,
  }) async {
    assert([CollectState.collected, CollectState.notCollect].contains(oldCollectState));
    CollectState oldState = state!;
    CollectState newState;
    notifyGlobal(CollectState.collecting);
    bool result = false;

    try {
      result = (worksType == WorksType.novel)
          ? await ApiNovels(requester).collectNovel(novelId: worksId, tags: tagNameList, restrict: restrict)
          : await ApiIllusts(requester).collectIllust(illustId: worksId, tags: tagNameList, restrict: restrict);
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
}
