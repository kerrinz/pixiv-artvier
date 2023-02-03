import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_user.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/model_response/user/user_detail.dart';

/// 用户详情
final userDetailProvider =
    AutoDisposeAsyncNotifierProviderFamily<UserDetailNotifier, UserDetail, String>(UserDetailNotifier.new);

/// 用户详情
///
/// arg为userId
class UserDetailNotifier extends BaseAutoDisposeFamilyAsyncNotifier<UserDetail, String> {
  late final String userId;

  final CancelToken _cancelToken = CancelToken();

  @override
  FutureOr<UserDetail> build(String arg) async {
    ref.onCancel(() {
      if (!_cancelToken.isCancelled) _cancelToken.cancel();
    });
    userId = arg;
    return fetch();
  }

  /// 初始化数据
  Future<UserDetail> fetch() async {
    var result = await ApiUser(requester).userDetail(userId);
    return result;
  }

  /// 下拉刷新
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 失败后的重试，或者用于重新加载
  Future<void> reload() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}
