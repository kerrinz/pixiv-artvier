import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/api_app/api_novels.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/business_component/advanced_collecting_bottom_sheet/model/advanced_collecting_data.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:pixgem/global/provider/collection_state_provider.dart';
import 'package:pixgem/model_response/common/collection_detail.dart';

/// 高级收藏的页面状态
final advancedCollectingPageStateProvider = StateProvider.autoDispose<PageState>((ref) => PageState.loading);

/// 高级收藏展示的内容（美术作品）
final advancedCollectingArtworkDetailProvider = StateNotifierProvider.autoDispose
    .family<CollectionTagsNotifier, AdvancedCollectingDataModel, String>((ref, worksId) {
  return CollectionTagsNotifier(
    AdvancedCollectingDataModel(restrict: Restrict.public, tags: [], isCollected: false),
    ref: ref,
    worksId: worksId,
    worksType: WorksType.illust,
  )..request();
});

/// 高级收藏展示的内容（小说）
final advancedCollectingNovelDetailProvider = StateNotifierProvider.autoDispose
    .family<CollectionTagsNotifier, AdvancedCollectingDataModel, String>((ref, worksId) {
  return CollectionTagsNotifier(
    AdvancedCollectingDataModel(restrict: Restrict.public, tags: [], isCollected: false),
    ref: ref,
    worksId: worksId,
    worksType: WorksType.novel,
  )..request();
});

/// 高级收藏展示的内容
class CollectionTagsNotifier extends BaseStateNotifier<AdvancedCollectingDataModel> {
  CollectionTagsNotifier(
    super.state, {
    required super.ref,
    required this.worksId,
    required this.worksType,
  });

  final String worksId;

  final WorksType worksType;

  CancelToken cancelToken = CancelToken();

  void update(newState) {
    state = newState;
  }

  void _notifyGlobal(CollectState collectState) {
    ref
        .read(globalArtworkCollectionStateChangedProvider.notifier)
        .update((state) => CollectStateChangedArguments(state: collectState, worksId: worksId));
  }

  /// 获取标签列表
  Future<void> request() async {
    ref.read(advancedCollectingPageStateProvider.notifier).update((state) => PageState.loading);

    try {
      var result = worksType == WorksType.novel
          ? await ApiNovels(requester).novelCollectionDetail(worksId, cancelToken: cancelToken)
          : await ApiIllusts(requester).illustCollectionDetail(worksId, cancelToken: cancelToken);
      state = state.copyWith(
        restrict: result.detail?.restrict == Restrict.private.name
            ? Restrict.private
            : Restrict.public,
        tags: result.detail?.tags ?? [],
      );
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.cancel) return;
      ref.read(advancedCollectingPageStateProvider.notifier).update((state) => PageState.error);
    }
  }

  /// 收藏该作品
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> collect({
    AdvancedCollectingDataModel? args,
    bool throwException = true,
  }) async {
    bool result = false;
    var tags = [for (WorksCollectTag item in args?.tags ?? []) item.name!];

    try {
      result = worksType == WorksType.novel
          ? await ApiNovels(requester).collectNovel(novelId: worksId, tags: tags, restrict: args?.restrict)
          : await ApiIllusts(requester).collectIllust(illustId: worksId, tags: tags, restrict: args?.restrict);
    } catch (e) {
      _notifyGlobal(state.isCollected ? CollectState.collected : CollectState.notCollect);
      if (throwException) {
        rethrow;
      }
    }

    if (result) {
      _notifyGlobal(CollectState.collected);
    } else {
      _notifyGlobal(state.isCollected ? CollectState.collected : CollectState.notCollect);
    }
    return result;
  }

  /// 添加标签
  void addTag(String name, bool isSelected) {
    state.tags.add(WorksCollectTag(name: name, isRegistered: isSelected));
    state = state.copyWith();
  }

  /// 更新标签
  void updateTag(int index, WorksCollectTag tag) {
    state.tags[index] = tag;
    state = state.copyWith();
  }

  /// 更新隐私限制
  void updateRestrict(Restrict restrict) {
    state = state.copyWith(restrict: restrict);
  }

  @override
  void dispose() {
    if (!cancelToken.isCancelled) cancelToken.cancel();
    super.dispose();
  }
}
