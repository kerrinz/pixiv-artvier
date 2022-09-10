import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pixgem/common_provider/global_provider.dart';
import 'package:pixgem/config/theme_colors.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/store/theme_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/booting_page.dart';
import 'store/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 启动之前加载高优先的数据，其他低优先度的数据在BootingPage里进行加载
  await beforeRunApp();
  // 运行APP
  runApp(const MyApp());
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
    ThemeData themeDataLight = PurpleTheme.themeData;
    ThemeData themeDataDark = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
      ),
      colorScheme: ColorScheme.dark(
        primary: Colors.cyan,
        primaryContainer: Colors.cyan.shade700,
        secondary: Colors.orangeAccent,
        secondaryContainer: Colors.orangeAccent.shade400,
        // onPrimary: Colors.black,
      ),
    );
    return ChangeNotifierProvider(
      create: (context) => GlobalStore.globalProvider,
      child: Selector(
        selector: (BuildContext context, GlobalProvider provider) {
          return provider.themeMode;
        },
        builder: (BuildContext context, ThemeMode mode, Widget? child) {
          return MaterialApp(
            title: 'Pixgem',
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
              GlobalWidgetsLocalizations.delegate,
              LocalizationIntlDelegate(),
            ],
            supportedLocales: const [
              Locale('zh', 'CN'),
              Locale('en', 'US'),
            ],
            // 切换系统语言时的回调函数
            localeListResolutionCallback: (locales, supportedLocales) {
              if (locales == null) return const Locale('en', 'US'); // 获取不到系统语言时的默认App语言
              for (Locale locale in locales) {
                if (supportedLocales.contains(locale)) return locale;
              }
              return const Locale('en', 'US');
            },
          );
        },
      ),
    );
  }
}
