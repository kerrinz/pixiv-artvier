import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

abstract class BasePage extends ConsumerWidget {
  const BasePage({super.key});

  LocalizationIntl l10n(context) => LocalizationIntl.of(context);

  ColorScheme colorScheme(context) => Theme.of(context).colorScheme;
  TextTheme textTheme(context) => Theme.of(context).textTheme;

  // 淡入过渡跳转页面
  static Route createFadeRoute(String routeName, {Object? arguments}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        RouteWidgetBuilder builder = Routes.match(context, routeName);
        return builder(context, arguments);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  // 模态框路由动画
  static Route createModalRoute(String routeName, {Object? arguments}) {
    return MaterialWithModalsPageRoute(
      builder: (context) {
        RouteWidgetBuilder builder = Routes.match(context, routeName);
        return builder(context, arguments);
      },
    );
  }
}

abstract class BaseStatefulPage extends ConsumerStatefulWidget {
  const BaseStatefulPage({super.key});
}

abstract class BasePageState<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  LocalizationIntl get l10n => LocalizationIntl.of(context);
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  TextTheme get textTheme => Theme.of(context).textTheme;

  /// Toolbar height + StatusBar height
  double get toolBarFullHeight =>
      (Theme.of(context).appBarTheme.toolbarHeight ?? 0) + MediaQuery.paddingOf(context).top;
}
