import 'package:artvier/model_response/common/common_tag.dart';
import 'package:artvier/model_response/user/common_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blocking_page_arguments.freezed.dart';

/// 屏蔽设定页面的传递参数
@Freezed(
  copyWith: true,
)
class BlockingPageArguments with _$BlockingPageArguments {
  const factory BlockingPageArguments({
    required List<CommonUser> users,
    required List<CommonTag> tags,
  }) = _BlockingPageArguments;
}
