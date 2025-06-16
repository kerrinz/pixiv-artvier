import 'package:artvier/component/tab_view/tab_indicator.dart';
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

  ColorScheme get colorScheme => (_brightness == Brightness.light ? lightColorScheme : darkColorScheme);

  bool get isLight => _brightness == Brightness.light;

  get textThemeOnLight => const TextTheme(
        bodyLarge: TextStyle(color: Color(0xff000000), fontSize: 14),
        bodyMedium: TextStyle(color: Color(0xff222222), fontSize: 14),
        bodySmall: TextStyle(color: Color(0xff222222), fontSize: 12),
      );

  /// 主题的核心配置，默认主题配置都在这里定义
  get themeData => ThemeData(
        colorScheme: colorScheme,
        primaryColor: colorScheme.primary,
        scaffoldBackgroundColor: colorScheme.background,
        appBarTheme: AppBarTheme(
          toolbarHeight: 50,
          scrolledUnderElevation: 0,
          color: colorScheme.surface,
          titleTextStyle: TextStyle(fontSize: 18, color: colorScheme.onSurface, fontWeight: FontWeight.w600),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: colorScheme.brightness == Brightness.light ? Colors.black : Colors.white,
          labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          unselectedLabelColor: colorScheme.onSurface.withAlpha(150),
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          indicatorSize: TabBarIndicatorSize.label,
          dividerHeight: 0,
          indicator: CustomUnderlineTabIndicator(
            indicatorWidth: 16,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 3,
              color: colorScheme.primary,
            ),
          ),
        ),
        indicatorColor: colorScheme.primary,
        cardTheme: CardTheme(
          color: colorScheme.surface,
          surfaceTintColor: colorScheme.surface,
          elevation: 1.0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: CircleBorder(),
        ),
        useMaterial3: true,
        splashFactory: InkSparkle.splashFactory,        
        // textTheme: BaseTheme.textTheme,
      );
}

class PurpleTheme extends BaseTheme {
  PurpleTheme(Brightness brightness) : super(brightness, lightColorScheme_, darkColorScheme_);

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
        background: Color(0xffF5F5F5),
        onBackground: Color(0xff1C1B1F),
        surface: Color(0xffffffff),
        onSurface: Color(0xff313033),
        surfaceVariant: Color(0xffF4F4F4),
        onSurfaceVariant: Color(0xff49454F),
        outline: Color(0xffAEA9B4),
      );

  static get darkColorScheme_ => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xffD0BCFF),
        onPrimary: Color(0xff381E72),
        primaryContainer: Color(0xff4F378B),
        onPrimaryContainer: Color(0xffEADDFF),
        secondary: Color(0xffCCC2DC),
        onSecondary: Color(0xff332D41),
        secondaryContainer: Color(0xff4A4458),
        onSecondaryContainer: Color(0xffE8DEF8),
        tertiary: Color(0xffEFB8C8),
        onTertiary: Color(0xff492532),
        tertiaryContainer: Color(0xff633B48),
        onTertiaryContainer: Color(0xffFFD8E4),
        error: Color(0xffF2B8B5),
        onError: Color(0xff601410),
        errorContainer: Color(0xff8C1D18),
        onErrorContainer: Color(0xffF9DEDC),
        background: Color(0xff181818),
        onBackground: Color(0xffE6E1E5),
        surface: Color(0xff222222),
        onSurface: Color(0xffE6E1E5),
        surfaceVariant: Color(0xff383838),
        onSurfaceVariant: Color(0xffCAC4D0),
        outline: Color(0xff938F99),
      );
}
