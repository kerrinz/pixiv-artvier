import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_detail_page_args.freezed.dart';

/// 小说详情页面的传递参数
@Freezed(copyWith: true)
class NovelDetailPageArguments with _$NovelDetailPageArguments {
  const factory NovelDetailPageArguments({
    required String worksId,
    String? title,
    CommonNovel? detail,
  }) = _NovelDetailPageArguments;
}
