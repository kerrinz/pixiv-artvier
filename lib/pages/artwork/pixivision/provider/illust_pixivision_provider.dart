import 'dart:async';

import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/pages/artwork/pixivision/model/pixivision_webview_page_arguments.dart';

class IllustPixivisionNotifier extends BaseAutoDisposeFamilyAsyncNotifier<String, PixivisionWebViewPageArguments> {
  late String language;
  late int id;

  IllustPixivisionNotifier();

  @override
  FutureOr<String> build(PixivisionWebViewPageArguments arg) async {
    language = arg.language;
    id = arg.id;
    return fetch();
  }

  /// 初始化数据
  Future<String> fetch() async {
    var result = await ApiIllusts(requester).illustPixvisionWebContent(language, id);
    return result;
  }
}
