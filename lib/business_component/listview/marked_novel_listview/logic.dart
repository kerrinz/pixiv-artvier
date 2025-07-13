import 'package:artvier/model_response/novels/marker_novel.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin MarkedNovelListViewLogic {
  WidgetRef get ref;

  void handleTapItem(MarkedNovel marked) {
    if (marked.novelMarker != null) {
      Navigator.of(ref.context).pushNamed(
        RouteNames.novelDetail.name,
        arguments: NovelDetailPageArguments(
            detail: marked.novel, novelId: marked.novel.id.toString(), toPage: marked.novelMarker!.page),
      );
    }
  }
}
