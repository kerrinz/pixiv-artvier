import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/common_provider/global_provider.dart';
import 'package:pixgem/config/themes.dart';
import 'package:pixgem/global/provider/shared_preferences.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/storage/theme_store.dart';
import 'package:provider/provider.dart' as prov;
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/booting_page.dart';
import 'global/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 启动之前加载高优先的数据，其他低优先度的数据在BootingPage里进行加载
  await beforeRunApp();
  // Get the instance of shared preferences
  final prefs = await SharedPreferences.getInstance();
  // 运行APP，注入Riverpod
  runApp(
    ProviderScope(
      overrides: [
        globalSharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
  // 状态栏无前景色的沉浸式
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

beforeRunApp() async {
  GlobalStore.globalProvider = GlobalProvider();
  GlobalStore.globalSharedPreferences = await SharedPreferences.getInstance();
  GlobalStore.globalProvider.setThemeMode(ThemeStore.getThemeMode(), false); // 提前得知主题模式（例如暗黑模式）
}

// 初始化一些APP全局设定，不加载内容
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeDataLight = Themes.match(ThemeTypes.purple, Brightness.light).themeData;
    ThemeData themeDataDark = Themes.match(ThemeTypes.purple, Brightness.dark).themeData;
    return prov.ChangeNotifierProvider(
      create: (context) => GlobalStore.globalProvider,
      child: prov.Selector(
        selector: (BuildContext context, GlobalProvider provider) {
          return provider.themeMode;
        },
        builder: (BuildContext context, ThemeMode mode, Widget? child) {
          return MaterialApp(
            title: 'Pixgem',
            debugShowCheckedModeBanner: false, // 禁用Debug角标
            onGenerateRoute: (RouteSettings settings) {
              RouteWidgetBuilder builder = Routes.match(context, settings.name);
              return MaterialPageRoute(builder: (context) => builder(context, settings.arguments));
            },
            // 启动加载页面，在这里面初始化全局数据
            home: const BootingPage(),
            theme: themeDataLight,
            darkTheme: themeDataDark,
            themeMode: mode,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              LocalizationIntlDelegate(),
            ],
            supportedLocales: LocalizationIntl.supportedLocales,
            // locale: LocalizationIntl.supportedLocales[0],
            // 切换系统语言时的回调函数
            localeListResolutionCallback: (locales, supportedLocales) {
              if (locales == null) return const Locale('en'); // 获取不到系统语言时的默认App语言
              for (Locale locale in locales) {
                Locale formatLocale = Locale.fromSubtags(
                  languageCode: locale.languageCode,
                  scriptCode: locale.scriptCode,
                ); // 不考虑countryCode
                if (supportedLocales.contains(formatLocale)) return formatLocale;
              }
              return const Locale('en');
            },
          );
        },
      ),
    );
  }
}
