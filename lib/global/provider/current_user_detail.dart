import 'dart:async';

import 'package:artvier/global/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_user.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/model_response/user/user_detail.dart';

/// 当前用户的详细信息。
///
/// 不使用 autoDispose：个人页在 PageView 里会被临时建起再卸掉，
/// 请求还在飞时 notifier 被 dispose，随后 `state =` 会抛
/// "Tried to use CurrentUserDetailNotifier after dispose was called"。
final globalCurrentUserDetailProvider = StateNotifierProvider<CurrentUserDetailNotifier, UserDetail?>((ref) {
  final userId = ref.watch(globalCurrentAccountProvider.select((account) => account?.user.id));
  return CurrentUserDetailNotifier(null, ref: ref, userId: userId)..fetch();
});

/// 当前用户的详细信息
class CurrentUserDetailNotifier extends BaseStateNotifier<UserDetail?> {
  CurrentUserDetailNotifier(super.state, {required super.ref, required this.userId});

  final String? userId;

  final CancelToken _cancelToken = CancelToken();

  Future<void> fetch() async {
    if (userId == null) return;
    try {
      final detail = await ApiUser(requester).userDetail(userId!, cancelToken: _cancelToken);
      if (!mounted) return;
      state = detail;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.cancel || !mounted) return;
      logger.e(error);
    } catch (error) {
      if (!mounted) return;
      logger.e(error);
    }
  }

  /// 失败后的重试
  Future<void> retry() async => fetch();

  @override
  void dispose() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
    super.dispose();
  }
}
