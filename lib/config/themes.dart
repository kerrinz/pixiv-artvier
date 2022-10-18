import 'package:flutter/material.dart';

typedef ThemeDataBuilder = BaseTheme Function(Brightness brightness);

/// 主题类型
enum ThemeTypes {
  purple,
  // customize,
}

/// 主题工具类
class Themes {
  static get themesMap => <String, ThemeDataBuilder>{
        ThemeTypes.purple.name: (brightness) => PurpleTheme(brightness),
      };

  /// 通过主题枚举类型
  static BaseTheme match(ThemeTypes type, Brightness brightness) {
    return themesMap[type.name](brightness) ?? PurpleTheme(brightness);
  }
}

/// 主题的基类
abstract class BaseTheme {
  BaseTheme(
    this._brightness,
    this.lightColorScheme,
    this.darkColorScheme,
  );

  final Brightness _brightness;

  ColorScheme lightColorScheme;

  ColorScheme darkColorScheme;

  ColorScheme get colorScheme => (_brightness == Brightness.light ? lightColorScheme : lightColorScheme);

  AppBarTheme appBarTheme = const AppBarTheme(shadowColor: Colors.transparent);

  get textThemeOnLight => const TextTheme(
        bodyText1: TextStyle(color: Color(0xff000000), fontSize: 14),
        bodyText2: TextStyle(color: Color(0xff222222), fontSize: 14),
        caption: TextStyle(color: Color(0xff222222), fontSize: 12),
      );

  get themeData => ThemeData(
        colorScheme: colorScheme,
        primaryColor: colorScheme.primary,
        backgroundColor: colorScheme.background,
        appBarTheme: appBarTheme,
        // useMaterial3: true,
        // textTheme: BaseTheme.textTheme,
      );
}

class PurpleTheme extends BaseTheme {
  PurpleTheme(Brightness brightness) : super(brightness, lightColorScheme_, lightColorScheme_);

  static get lightColorScheme_ => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff6750A4),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xffEADDFF),
        onPrimaryContainer: Color(0xff21005D),
        secondary: Color(0xff625B71),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xffE8DEF8),
        onSecondaryContainer: Color(0xff1D192B),
        tertiary: Color(0xff7D5260),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xffFFD8E4),
        onTertiaryContainer: Color(0xff31111D),
        error: Color(0xffB3261E),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffF9DEDC),
        onErrorContainer: Color(0xff410E0B),
        background: Color(0xffF0F1F2),
        onBackground: Color(0xff1C1B1F),
        surface: Color(0xffffffff),
        onSurface: Color(0xff313033),
        surfaceVariant: Color(0xffF4EFF4),
        onSurfaceVariant: Color(0xff49454F),
        outline: Color(0xffAEA9B4),
      );
}
