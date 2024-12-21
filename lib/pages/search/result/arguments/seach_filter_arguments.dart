import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:artvier/api_app/api_serach.dart';

part 'seach_filter_arguments.freezed.dart';

@Freezed(
  copyWith: true,
)

/// 搜索结果页，筛选的参数
class SearchFilterArguments with _$SearchFilterArguments {
  const factory SearchFilterArguments({
    /// 最小收藏数筛选
    int? minCollectCount,

    /// 搜索对象
    @Default(ApiSearchConstants.tagPerfectMatch) String? searchTarget,

    /// AI
    @Default(0) int? searchAiType,

    /// 最早日期
    String? startDate,

    /// 最晚日期
    String? endDate,

    /// 排序方式
    @Default(ApiSearchConstants.dateDesc) String sort,

    /// 匹配规则
    @Default(ApiSearchConstants.tagPartialMatch) String match,
  }) = _SearchFilterArguments;
}
