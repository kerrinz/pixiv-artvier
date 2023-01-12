import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:pixgem/global/provider/illust_collect_provider.dart';
import 'package:pixgem/pages/artwork/detail/advanced_collect__bottom_sheet.dart';

/// 插画详情页的收藏状态
/// 可能有多个插画详情页同时存在于页面栈中，因此使用.family为不同插画id做区分
// final illustDetailCollectStateProvider =
//     StateNotifierProvider.autoDispose.family<CollectNotifier, CollectState, String>((ref, illustId) {
//   var args = ref.watch(globalIllustCollectStateChangedProvider);
//   if (args != null && args.worksId == illustId) {
//     return CollectNotifier(
//       args.state,
//       ref: ref,
//       worksId: illustId,
//     );
//   }
//   return CollectNotifier(
//     ref.watch(illustDetailProvider(illustId))?.isBookmarked ?? false ? CollectState.collected : CollectState.notCollect,
//     ref: ref,
//     worksId: illustId,
//   );
// });

/// 收藏
class CollectNotifier extends StateNotifier<CollectState> {
  CollectNotifier(CollectState initValue, {required this.ref, required this.worksId}) : super(initValue);

  @override
  void dispose() {
    super.dispose();
  }

  final Ref ref;

  final String worksId;

  void setCollectState(CollectState newState) {
    state = newState;
  }

  void notifyGlobal() {
    ref
        .read(globalIllustCollectStateChangedProvider.notifier)
        .update((args) => CollectStateChangedArguments(state: state, worksId: worksId));
  }

  /// 收藏该作品
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> collect({
    AdvancedCollectArguments? args,
    bool throwException = true,
  }) async {
    state = CollectState.collecting;
    bool result = false;
    try {
      result = await ApiIllusts().addIllustBookmark(
        illustId: worksId,
        tags: args?.tags,
        restrict: args?.restrict,
      );
    } catch (e) {
      state = CollectState.notCollect;
      if (throwException) {
        notifyGlobal();
        rethrow;
      }
    }
    if (result) {
      state = CollectState.collected;
    } else {
      state = CollectState.notCollect;
    }
    notifyGlobal();
    return result;
  }

  /// 移除收藏该作品
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> uncollect({
    bool throwException = true,
  }) async {
    state = CollectState.uncollecting;
    bool result = false;
    try {
      result = await ApiIllusts().deleteIllustBookmark(illustId: worksId);
    } catch (e) {
      state = CollectState.collected;
      if (throwException) {
        notifyGlobal();
        rethrow;
      }
    }
    if (result) {
      state = CollectState.notCollect;
    } else {
      state = CollectState.collected;
    }
    notifyGlobal();
    return result;
  }
}
