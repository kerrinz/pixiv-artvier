import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 根据小说阅读字体预设生成 [TextStyle]。
///
/// [fontFamily] 为 Google Fonts 族名；空则使用 [textStyle] / 默认样式。
TextStyle novelViewerFontTextStyle({
  String? fontFamily,
  TextStyle? textStyle,
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  final base = textStyle ?? const TextStyle();
  if (fontFamily == null || fontFamily.isEmpty) {
    return base.copyWith(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: base,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  } catch (_) {
    // 预设名无效时回退，避免阅读页崩溃
    return base.copyWith(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
