import 'dart:async';

import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/business_component/series/series_navigation_model.dart';
import 'package:artvier/config/enums.dart';

/// 系列追更按钮
class SeriesWatchButtonNotifier extends BaseStateNotifier<SeriesNavigationModel> {
  SeriesWatchButtonNotifier(super.state, {required this.seriesId, required this.worksType, required super.ref});

  final String seriesId;
  final WorksType worksType;

  Future<SeriesNavigationModel> addSeriesToWatchlist() async {
    state = state.copyWith(loadstate: LoadState.loading);
    try {
      final result = worksType == WorksType.illust
          ? await ApiIllusts(requester).addIllustSeriesWatchlist(seriesId: seriesId)
          : await ApiNovels(requester).addNovelSeriesWatchlist(seriesId: seriesId);
      if (result) {
        state = state.copyWith(loadstate: LoadState.completed, seriesIsWatched: true);
      } else {
        state = state.copyWith(loadstate: LoadState.completed);
      }
    } catch (e) {
      state = state.copyWith(loadstate: LoadState.completed);
      rethrow;
    }
    return state;
  }

  Future<SeriesNavigationModel> removeSeriesFromWatchlist() async {
    state = state.copyWith(loadstate: LoadState.loading);
    try {
      final result = worksType == WorksType.illust
          ? await ApiIllusts(requester).removeIllustSeriesWatchlist(seriesId: seriesId)
          : await ApiNovels(requester).removeNovelSeriesWatchlist(seriesId: seriesId);
      if (result) {
        state = state.copyWith(loadstate: LoadState.completed, seriesIsWatched: false);
      } else {
        state = state.copyWith(loadstate: LoadState.completed);
      }
    } catch (e) {
      state = state.copyWith(loadstate: LoadState.completed);
      rethrow;
    }
    return state;
  }
}
