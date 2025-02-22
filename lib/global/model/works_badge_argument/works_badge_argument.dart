import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'works_badge_argument.freezed.dart';

/// 作品角标的参数
@Freezed(
  copyWith: true,
)
class WorksBadgeArgument with _$WorksBadgeArgument {
  const factory WorksBadgeArgument({
    required String text,
    Color? textColor,
    Color? backgroundColor,
  }) = _WorksBadgeArgument;
}
