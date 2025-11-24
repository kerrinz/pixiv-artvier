import 'dart:async';

import 'package:artvier/api_app/api_serach.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/following_state_changed_arguments%20copy/following_state_changed_arguments.dart';
import 'package:artvier/global/provider/follow_state_provider.dart';
import 'package:artvier/model_response/common/predictive_search.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';
import 'package:artvier/pages/main_navigation_tab_page/search/provider/search_input_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final predictiveSearchWorksProvider =
    AutoDisposeAsyncNotifierProvider<PredictiveSearchWorksNotivier, List<PredictiveSearchWorksTag>>(
  () => PredictiveSearchWorksNotivier(),
);

final predictiveSearchUsersProvider =
    AutoDisposeAsyncNotifierProvider<PredictiveSearchUsersNotivier, List<CommonUserPreviews>>(
  () => PredictiveSearchUsersNotivier(),
);

class PredictiveSearchWorksNotivier extends BaseAutoDisposeAsyncNotifier<List<PredictiveSearchWorksTag>> {
  PredictiveSearchWorksNotivier();

  String searchWord = "";

  CancelToken cancelToken = CancelToken();

  @override
  FutureOr<List<PredictiveSearchWorksTag>> build() {
    ref.onDispose(() {
      if (!cancelToken.isCancelled) cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<PredictiveSearchWorksTag>> fetch() async {
    final searchWord = ref.read(searchInputProvider);
    if (searchWord.trim() == "") return Future.value([]);

    final result = await ApiSearch(requester).predictiveSearchIllust(
      searchWord,
      cancelToken: cancelToken,
    );
    return result.tags;
  }

  /// 使用新关键词搜索
  Future<void> search(String searchWord) async {
    // state = const AsyncValue.loading();
    this.searchWord = searchWord;
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}

class PredictiveSearchUsersNotivier extends BaseAutoDisposeAsyncNotifier<List<CommonUserPreviews>> {
  PredictiveSearchUsersNotivier();

  String searchWord = "";

  CancelToken cancelToken = CancelToken();

  String? nextUrl;

  @override
  FutureOr<List<CommonUserPreviews>> build() {
    // 监听全局变化
    ref.listen<FollowingStateChangedArguments?>(globalFollowingStateChangedProvider, (previous, next) {
      final value = state.value;
      if (next == null ||
          value == null ||
          ![UserFollowState.followed, UserFollowState.notFollow].contains(next.state)) {
        return;
      }
      for (int i = 0; i < value.length; i++) {
        final valueItem = value[i];
        if (valueItem.user.id.toString() != next.userId) return;
        if (next.state == UserFollowState.followed) {
          update((p0) => p0..[i].user = p0[i].user.copyWith(isFollowed: true));
        } else if (next.state == UserFollowState.notFollow) {
          update((p0) => p0..[i].user = p0[i].user.copyWith(isFollowed: false));
        }
      }
    });
    ref.onDispose(() {
      if (!cancelToken.isCancelled) cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonUserPreviews>> fetch() async {
    final searchWord = ref.read(searchInputProvider);
    if (searchWord.trim() == "") return Future.value([]);

    final result = await ApiSearch(requester).predictiveSearchUsers(
      searchWord,
      cancelToken: cancelToken,
    );
    nextUrl = result.nextUrl;
    return result.users;
  }

  /// 使用新关键词搜索
  Future<void> search(String searchWord) async {
    // state = const AsyncValue.loading();
    this.searchWord = searchWord;
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}
