import 'dart:async';

import 'package:artvier/api_app/api_update.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/provider/requester_provider.dart';
import 'package:artvier/model_response/update/git_release.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageInfoProvider = FutureProvider.autoDispose<PackageInfo>((ref) async {
  return PackageInfo.fromPlatform();
});

final globalLastVersionProvider = AsyncNotifierProvider<LastVersionNotifier, GitRelease>(() {
  return LastVersionNotifier();
});

class LastVersionNotifier extends BaseAsyncNotifier<GitRelease> {
  CancelToken cancelToken = CancelToken();

  @override
  FutureOr<GitRelease> build() {
    ref.onDispose(() {
      if (!cancelToken.isCancelled) cancelToken.cancel();
    });
    return fetch();
  }

  @override
  Future<GitRelease> fetch() {
    return ApiUpdate(ref.read(originHttpRequesterProvider)).lastRelease(cancelToken: cancelToken);
  }
}
