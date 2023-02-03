import 'dart:async';

import 'package:dio/dio.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

// 相关作品
class RelatedArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>>
    with IllustListAsyncNotifierMixin {
  RelatedArtworksNotifier({required this.worksId});

  final String worksId;

  @override
  FutureOr<List<CommonIllust>> build() async {
    beforeBuild(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    try {
      var result = await ApiIllusts(requester).getRelatedIllust(worksId, cancelToken: cancelToken);
      nextUrl = result.nextUrl;
      return result.illusts;
    } catch (e) {
      if (!(e is DioError && e.type == DioErrorType.cancel)) logger.e(e);
      rethrow;
    }
  }
}
