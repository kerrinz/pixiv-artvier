import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_model.freezed.dart';

/// APP 语言
@Freezed(
  copyWith: true,
)
class LanguageModel with _$LanguageModel {
  // ignore: unused_element
  const LanguageModel._();

  Locale get finalLocale => appLocale ?? callbackLocale;

  const factory LanguageModel({
    /// MaterialApp locale，当 null 时为跟随系统
    required Locale? appLocale,

    /// 跟随系统回调的 Locale
    required Locale callbackLocale,
  }) = _LanguageModel;
}
