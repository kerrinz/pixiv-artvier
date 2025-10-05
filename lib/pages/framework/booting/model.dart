import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

/// 图片多种画质的链接
@Freezed(
  copyWith: true,
)
class BootingPageArguments with _$BootingPageArguments {
  const factory BootingPageArguments({
    /// 跳转下一个页面的路由名
    required String nextRoute,

    /// 跳转下一个页面的路由携带参数
    Object? nextRouteArguments,
  }) = _BootingPageArguments;
}
