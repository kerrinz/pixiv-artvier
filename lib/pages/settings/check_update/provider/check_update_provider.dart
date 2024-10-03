import 'dart:async';

import 'package:artvier/api_app/api_update.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/provider/requester_provider.dart';
import 'package:artvier/model_response/update/git_release.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changeLogProvider = AutoDisposeAsyncNotifierProvider.family<ChangeLogNotifier, GitRelease, String>(() {
  return ChangeLogNotifier();
});

class ChangeLogNotifier extends BaseAutoDisposeFamilyAsyncNotifier<GitRelease, String> {
  CancelToken cancelToken = CancelToken();

  @override
  FutureOr<GitRelease> build(String arg) {
    ref.onDispose(() {
      if (!cancelToken.isCancelled) cancelToken.cancel();
    });
    return fetch();
  }

  @override
  Future<GitRelease> fetch() {
    return ApiUpdate(ref.read(originHttpRequesterProvider)).releaseDetails(arg, cancelToken: cancelToken);
  }
}
