import 'package:artvier/global/model/series_state_changed_arguments/series_state_changed_arguments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/model/advanced_collecting_data.dart';
import 'package:artvier/config/enums.dart';

/// 插画漫画系列的追更状态
final globalArtworkSeriesStateChangedProvider = StateProvider<SeriesStateChangedArguments?>((ref) {
  return null;
});

/// 小说系列的追更状态
final globalNovelSeriesStateChangedProvider = StateProvider<SeriesStateChangedArguments?>((ref) {
  return null;
});

class SeriesStateNotifier extends BaseStateNotifier<SeriesState> {
  SeriesStateNotifier(
    super.state, {
    required super.ref,
    required this.seriesId,
    required this.worksType,
  });

  final String seriesId;

  final WorksType worksType;

  void setSeriesState(SeriesState newState) {
    state = newState;
  }

  void notifyGlobal(SeriesState collectState) {
    (worksType == WorksType.novelSeries || worksType == WorksType.novel)
        ? ref
            .read(globalNovelSeriesStateChangedProvider.notifier)
            .update((args) => SeriesStateChangedArguments(state: collectState, seriesId: seriesId))
        : ref
            .read(globalArtworkSeriesStateChangedProvider.notifier)
            .update((args) => SeriesStateChangedArguments(state: collectState, seriesId: seriesId));
  }

  /// 追更该作品
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> addWatch({
    AdvancedCollectingDataModel? args,
    bool throwException = true,
  }) async {
    SeriesState oldState = state;
    SeriesState newState;
    notifyGlobal(SeriesState.adding);
    bool result = false;
    try {
      result = (worksType == WorksType.novel || worksType == WorksType.novelSeries)
          ? await ApiNovels(requester).addNovelSeriesWatchlist(seriesId: seriesId)
          : await ApiIllusts(requester).addIllustSeriesWatchlist(seriesId: seriesId);
      // 分析结果，取得新的状态
      newState = result ? SeriesState.watched : oldState;
      if (mounted) {
        state = newState;
      }
      notifyGlobal(newState);
    } catch (e) {
      // 复原状态
      if (mounted) state = oldState;
      notifyGlobal(oldState);
      if (throwException) {
        rethrow;
      }
    }
    return result;
  }

  /// 移除追更该作品
  /// - [throwException] 是否抛出异常；默认 true
  Future<bool> removeWatch({
    bool throwException = true,
  }) async {
    SeriesState oldState = state;
    SeriesState newState;
    notifyGlobal(SeriesState.removing);
    bool result = false;
    try {
      result = (worksType == WorksType.novel || worksType == WorksType.novelSeries)
          ? await ApiNovels(requester).removeNovelSeriesWatchlist(seriesId: seriesId)
          : await ApiIllusts(requester).removeIllustSeriesWatchlist(seriesId: seriesId);
      // 分析结果，取得新的状态
      newState = result ? SeriesState.notWatch : oldState;
      if (mounted) {
        state = newState;
      }
      notifyGlobal(newState);
    } catch (e) {
      // 复原状态
      if (mounted) state = oldState;
      notifyGlobal(oldState);
      if (throwException) {
        rethrow;
      }
    }
    return result;
  }
}
