import 'package:artvier/model_response/common/common_tag.dart';
import 'package:artvier/model_response/user/common_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'muted_page_arguments.freezed.dart';

/// 屏蔽设定页面的传递参数
@Freezed(
  copyWith: true,
)
class MutedPageArguments with _$MutedPageArguments {
  const factory MutedPageArguments({
    required List<CommonUser> users,
    required List<CommonTag> tags,
  }) = _MutedPageArguments;
}
