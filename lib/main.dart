import 'dart:io';

import 'package:artvier/config/constants.dart';
import 'package:artvier/global/provider/language_provider.dart';
import 'package:artvier/global/provider/version_and_update_provider.dart';
import 'package:artvier/global/variable.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/pages/framework/booting/booting_page.dart';
import 'package:artvier/pages/framework/booting/model.dart';
import 'package:artvier/pages/main_navigation_tab_page/main_navigation.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/request/my_http_overrides.dart';
import 'package:artvier/preferences/network_store.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Shared Preferences实例
  final prefs = await SharedPreferences.getInstance();
  globalSharedPreferences = prefs;
  // 启动之前加载数据
  await beforeRunApp();
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

  // Apply HttpOverrides with proxy
  HttpOverrides.global = MyHttpOverrides();
  final proxyStorage = NetworkStorage(globalSharedPreferences);
  String host = proxyStorage.getProxyHost() ?? CONSTANTS.proxy_default_host;
  String port = proxyStorage.getProxyPort() ?? CONSTANTS.proxy_default_port;
  MyHttpOverrides.instance.setProxyAddress(proxyStorage.getProxyEnable() ? "$host:$port" : null);
}

// 初始化一些APP全局设定，不加载内容
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  MaterialPageRoute? checkAppLinks(String? link) {
    if (link == null) return null;
    final uri = Uri.parse(link);
    if (uri.pathSegments[0].toLowerCase() == 'artworks') {
      final String artworkId = uri.pathSegments[1];
      if (RegExp(r'^\d+$').hasMatch(artworkId)) {
        final nextPageArgs = IllustDetailPageArguments(illustId: artworkId);
        final bootingPageArgs =
            BootingPageArguments(nextRoute: RouteNames.artworkDetail.name, nextRouteArguments: nextPageArgs);
        return MaterialPageRoute(builder: (context) => BootingPage(bootingPageArgs));
      }
    } else if (uri.pathSegments[0].toLowerCase() == 'users') {
      final String userId = uri.pathSegments[1];
      if (RegExp(r'^\d+$').hasMatch(userId)) {
        final nextPageArgs = PreloadUserLeastInfo(userId, null, null);
        final bootingPageArgs =
            BootingPageArguments(nextRoute: RouteNames.userDetail.name, nextRouteArguments: nextPageArgs);
        return MaterialPageRoute(builder: (context) => BootingPage(bootingPageArgs));
      }
    } else if (uri.pathSegments[0].toLowerCase() == 'novel') {
      final novelId = uri.queryParameters['id'];
      if (novelId != null && novelId != '') {
        if (RegExp(r'^\d+$').hasMatch(novelId)) {
          final nextPageArgs = NovelDetailPageArguments(novelId: novelId);
          final bootingPageArgs =
              BootingPageArguments(nextRoute: RouteNames.novelDetail.name, nextRouteArguments: nextPageArgs);
          return MaterialPageRoute(builder: (context) => BootingPage(bootingPageArgs));
        }
      }
    }
    return null;
  }

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
        // TODO: 更换新版路由
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => HomePage(),
        //   '/booting': (context) => BootingPage(),
        // },
        onGenerateRoute: (RouteSettings settings) {
          final result = checkAppLinks(settings.name);
          if (result != null) {
            return result;
          } else {
            RouteWidgetBuilder builder = Routes.match(context, settings.name);
            return MaterialPageRoute(builder: (context) => builder(context, settings.arguments));
          }
        },
        home: BootingPage(BootingPageArguments(nextRoute: RouteNames.mainNavigation.name)),
        navigatorObservers: [AutoHomeNavigatorObserver()],
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

// 全局的导航观察者
class AutoHomeNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // 检查 pop 后是否会导致黑屏
    if (previousRoute == null) {
      // 延迟执行，确保在导航栈更新后检查
      Future.microtask(() {
        final navigator = route.navigator;
        if (navigator != null && !navigator.canPop()) {
          // 路由栈为空，自动跳转到首页
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainNavigation()),
            (route) => false,
          );
        }
      });
    }
  }
}
