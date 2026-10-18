import 'package:artvier/model_response/novels/marker_novel.dart';
import 'package:artvier/component/layout/app_navigator.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin MarkedNovelListViewLogic {
  WidgetRef get ref;

  void handleTapItem(MarkedNovel marked) {
    if (marked.novelMarker != null) {
      AppNavigator.pushNamed(ref.context, 
        RouteNames.novelDetail.name,
        arguments: NovelDetailPageArguments(
            detail: marked.novel, novelId: marked.novel.id.toString(), toPage: marked.novelMarker!.page),
      );
    }
  }
}
