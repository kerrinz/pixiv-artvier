import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/model/advanced_collecting_data.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/provider/collecting_provider.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/common/collection_detail.dart';

/// 高级收藏展示的内容
class AdvancedCollectingStatesNotifier extends BaseAutoDisposeAsyncNotifier<AdvancedCollectingDataModel> {
  AdvancedCollectingStatesNotifier({
    required this.worksId,
    required this.worksType,
  });

  final String worksId;

  final WorksType worksType;

  final CancelToken _cancelToken = CancelToken();

  @override
  FutureOr<AdvancedCollectingDataModel> build() {
    ref.onDispose(() {
      if (!_cancelToken.isCancelled) {
        _cancelToken.cancel();
      }
    });
    return fetch();
  }

  Future<AdvancedCollectingDataModel> fetch() async {
    var res = worksType == WorksType.novel
        ? await ApiNovels(requester).novelCollectionDetail(worksId, cancelToken: _cancelToken)
        : await ApiIllusts(requester).illustCollectionDetail(worksId, cancelToken: _cancelToken);
    // 更新高级收藏的收藏状态
    ref
        .read(worksType == WorksType.novel
            ? novelAdvancedCollectingProvider(worksId).notifier
            : artworkAdvancedCollectingProvider(worksId).notifier)
        .update(res.detail!.isBookmarked! ? CollectState.collected : CollectState.notCollect);
    return AdvancedCollectingDataModel(
      collectState: res.detail!.isBookmarked! ? CollectState.collected : CollectState.notCollect,
      restrict: res.detail?.restrict == Restrict.private.name ? Restrict.private : Restrict.public,
      tags: res.detail?.tags ?? [],
    );
  }

  /// 重新载入
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await fetch();
    });
  }

  /// 添加标签（到头部）
  void addTag(String name, bool isSelected) {
    update(
      (p0) => p0.copyWith(
        tags: [WorksCollectTag(name: name, isRegistered: isSelected), ...p0.tags],
      ),
    );
  }

  /// 更新标签
  void updateTag(int index, {String? newName, bool? newIsSelected}) {
    update((p0) {
      if (newName != null) p0.tags[index].name = newName;
      if (newIsSelected != null) p0.tags[index].isRegistered = newIsSelected;
      return p0.copyWith();
    });
  }

  /// 更新隐私限制
  void updateRestrict(Restrict restrict) {
    update((p0) => p0.copyWith(restrict: restrict));
  }
}
