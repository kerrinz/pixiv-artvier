import 'dart:io';

import 'package:artvier/config/constants.dart';
import 'package:artvier/global/provider/language_provider.dart';
import 'package:artvier/global/provider/version_and_update_provider.dart';
import 'package:artvier/global/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/global/provider/themes_provider.dart';
import 'package:artvier/global/themes.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/framework/booting/booting_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 启动之前加载高优先的数据，其他低优先度的数据在BootingPage里进行加载
  await beforeRunApp();
  // Shared Preferences实例
  final prefs = await SharedPreferences.getInstance();
  globalSharedPreferences = prefs;
  // 运行APP，注入Riverpod
  runApp(
    ProviderScope(
      overrides: [
        globalSharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
  // 手势栏（小白条）沉浸
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // 状态栏无前景色的沉浸式
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

beforeRunApp() async {
  /// TODO: 动态 Headers
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // final iosInfo = await deviceInfo.deviceInfo;
  // print(iosInfo);
  // final machine = iosInfo.data["utsname"]?["machine"];

  globalBaseHttpHeaders = {
    HttpHeaders.userAgentHeader: "PixivIOSApp/7.20.18 (iOS 17.7; iPhone11,2)",
    "App-OS": "ios",
    "App-OS-Version": "17.7",
    "App-Version": "7.20.18",
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 除特定页面外，仅允许竖屏
    DeviceOrientation.portraitDown,
  ]);
}

// 初始化一些APP全局设定，不加载内容
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeDataLight = Themes.match(ThemeTypes.purple, Brightness.light).themeData;
    final themeDataDark = Themes.match(ThemeTypes.purple, Brightness.dark).themeData;
    final themeMode = ref.watch(globalThemeModeProvider);
    Brightness statusBarBrightness =
        (MediaQuery.platformBrightnessOf(context) == Brightness.light) ? Brightness.dark : Brightness.light;
    if (themeMode != ThemeMode.system) {
      statusBarBrightness = (themeMode == ThemeMode.light) ? Brightness.dark : Brightness.light;
    }
    final reverseStatusBarBrightness = statusBarBrightness == Brightness.light ? Brightness.dark : Brightness.light;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: reverseStatusBarBrightness,
        statusBarIconBrightness: statusBarBrightness,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        title: ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.appName) ?? "",
        debugShowCheckedModeBanner: false, // 禁用Debug角标
        onGenerateRoute: (RouteSettings settings) {
          RouteWidgetBuilder builder = Routes.match(context, settings.name);
          return MaterialPageRoute(builder: (context) => builder(context, settings.arguments));
        },
        // 启动加载页面，在这里面初始化全局数据
        home: const BootingPage(),
        theme: themeDataLight,
        darkTheme: themeDataDark,
        themeMode: themeMode,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          LocalizationIntlDelegate(),
        ],
        supportedLocales: LocalizationIntl.supportedLocales,
        locale: ref.watch(globalLanguageProvider.select((value) => value.appLocale)), // null 时自动跟随系统
        // 切换语言时的回调函数，包括APP内手动切换、跟随系统切换
        localeListResolutionCallback: (locales, supportedLocales) {
          if (ref.read(globalLanguageProvider).appLocale == null) {
            // 跟随系统切换
            Locale locale = findLocale(locales, supportedLocales);
            ref.read(globalLanguageProvider.notifier).sytemCallback(locale);
            return locale;
          }
          return null;
        },
      ),
    );
  }

  /// 匹配语言
  Locale findLocale(List<Locale>? locales, Iterable<Locale> supportedLocales) {
    const defaultLocale = Locale(CONSTANTS.default_language_code, CONSTANTS.default_country_code);
    if (locales == null) return defaultLocale;
    var formatLocales =
        locales.map((locale) => Locale.fromSubtags(languageCode: locale.languageCode, countryCode: locale.countryCode));
    // 精确匹配，语言+地区
    for (Locale locale in formatLocales) {
      if (supportedLocales.contains(locale)) {
        return locale;
      }
    }
    // 模糊匹配，仅语言
    for (Locale locale in formatLocales) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
    }
    return defaultLocale;
  }
}
