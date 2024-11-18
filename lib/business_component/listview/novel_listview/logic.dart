import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/model_response/novels/common_novel.dart';

mixin NovelListViewLogic {
  WidgetRef get ref;

  void handleTapItem(CommonNovel novel) {
    Navigator.of(ref.context).pushNamed(
      RouteNames.novelDetail.name,
      arguments: NovelDetailPageArguments(detail: novel, worksId: novel.id.toString()),
    );
  }
}
