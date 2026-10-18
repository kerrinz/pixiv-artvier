import 'package:artvier/routes.dart';
import 'package:flutter/widgets.dart';

/// 平板分栏时，作品详情等页面进右侧导航栈，列表留在左侧。
class TabletSplitScope extends InheritedWidget {
  const TabletSplitScope({
    super.key,
    required this.detailKey,
    required super.child,
  });

  final GlobalKey<NavigatorState> detailKey;

  static TabletSplitScope? maybeOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<TabletSplitScope>();
  }

  bool containsDetailContext(BuildContext context) {
    final state = detailKey.currentState;
    if (state == null) return false;
    return Navigator.of(context) == state;
  }

  Future<T?> openDetail<T extends Object?>(String routeName, {Object? arguments}) {
    final nav = detailKey.currentState;
    if (nav == null) {
      throw StateError('Detail navigator is not mounted');
    }
    return nav.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => route.isFirst,
      arguments: arguments,
    );
  }

  @override
  bool updateShouldNotify(TabletSplitScope oldWidget) => detailKey != oldWidget.detailKey;
}

/// 打开作品后在右侧替换当前详情，而不是盖住左侧列表。
final Set<String> kDetailRouteNames = {
  RouteNames.artworkDetail.name,
  RouteNames.novelDetail.name,
  RouteNames.artworkPixivition.name,
  RouteNames.mangaSeriesDetail.name,
  RouteNames.novelSeriesDetail.name,
  RouteNames.comments.name,
};

/// 盖住整个窗口，例如大图浏览。
final Set<String> kFullscreenRouteNames = {
  RouteNames.artworkImagesPreview.name,
};

/// 登录流程始终走根导航，避免被嵌在分栏里。
final Set<String> kRootRouteNames = {
  RouteNames.wizard.name,
  RouteNames.loginWeb.name,
  RouteNames.mainNavigation.name,
};

class AppNavigator {
  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    if (kFullscreenRouteNames.contains(routeName) || kRootRouteNames.contains(routeName)) {
      return Navigator.of(context, rootNavigator: true).pushNamed<T>(routeName, arguments: arguments);
    }
    final scope = TabletSplitScope.maybeOf(context);
    if (scope != null && kDetailRouteNames.contains(routeName) && !scope.containsDetailContext(context)) {
      return scope.openDetail<T>(routeName, arguments: arguments);
    }
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> push<T extends Object?>(BuildContext context, Route<T> route) {
    final name = route.settings.name;
    if (name != null && (kFullscreenRouteNames.contains(name) || kRootRouteNames.contains(name))) {
      return Navigator.of(context, rootNavigator: true).push<T>(route);
    }
    final scope = TabletSplitScope.maybeOf(context);
    if (name != null &&
        scope != null &&
        kDetailRouteNames.contains(name) &&
        !scope.containsDetailContext(context)) {
      final nav = scope.detailKey.currentState;
      if (nav != null) {
        return nav.pushAndRemoveUntil<T>(route, (entry) => entry.isFirst);
      }
    }
    return Navigator.of(context).push<T>(route);
  }
}
