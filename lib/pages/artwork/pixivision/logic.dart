import 'package:artvier/pages/artwork/pixivision/model/pixivision_webview_page_arguments.dart';
import 'package:artvier/pages/artwork/pixivision/provider/illust_pixivision_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin IllustPixivisionPageLogic {
  WidgetRef get ref;

  /// Language
  late String language;

  /// Pixvision ID
  late int pixvisionId;

  late final illustPixivisionProvier =
      AsyncNotifierProvider.autoDispose.family<IllustPixivisionNotifier, String, PixivisionWebViewPageArguments>(
    () => IllustPixivisionNotifier(),
  );
}
