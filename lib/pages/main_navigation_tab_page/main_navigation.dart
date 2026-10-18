/* APP主体内容框架：分页框架 （APP视觉上的起始页面）*/
import 'package:artvier/component/layout/adaptive.dart';
import 'package:artvier/component/layout/app_navigator.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/home_tabpage.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/newest_tabpage.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/profile_tabpage.dart';
import 'package:artvier/pages/main_navigation_tab_page/search/search_tabpage.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainNavigationState();
  }
}

class MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const SearchTabPage(),
    const NewArtworksTabPage(),
    const ProfileTabPage(),
  ];
  final PageController _pageController = PageController();
  final GlobalKey<NavigatorState> _masterNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _detailNavKey = GlobalKey<NavigatorState>();
  late final _NavSyncObserver _masterObserver = _NavSyncObserver(onChanged: _scheduleSync);
  late final _NavSyncObserver _detailObserver = _NavSyncObserver(onChanged: _scheduleSync);

  /// 导航器只创建一次。外壳每次 setState 如果换成新的 Navigator，
  /// 会强制重建已打开的页面，详情的滚动和图片状态就会丢掉。
  late final Widget _masterNav = _createMasterNavigator();
  late final Widget _detailNav = _createDetailNavigator();
  DateTime? _lastPressedBack;
  bool _detailCanPop = false;
  bool _masterCanPop = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _scheduleSync() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final detailCanPop = _detailNavKey.currentState?.canPop() ?? false;
      final masterCanPop = _masterNavKey.currentState?.canPop() ?? false;
      if (detailCanPop == _detailCanPop && masterCanPop == _masterCanPop) return;
      setState(() {
        _detailCanPop = detailCanPop;
        _masterCanPop = masterCanPop;
      });
    });
  }

  void _selectTab(int index) {
    final master = _masterNavKey.currentState;
    if (master != null && master.canPop()) {
      master.popUntil((route) => route.isFirst);
    }
    _pageController.jumpToPage(index);
  }

  void _onPopInvoked(bool didPop, Object? result) {
    if (didPop) return;
    if (isTabletWindow(context)) {
      final detail = _detailNavKey.currentState;
      if (detail != null && detail.canPop()) {
        detail.pop();
        return;
      }
      final master = _masterNavKey.currentState;
      if (master != null && master.canPop()) {
        master.pop();
        return;
      }
    }
    if (_lastPressedBack == null || DateTime.now().difference(_lastPressedBack!) > const Duration(seconds: 1)) {
      _lastPressedBack = DateTime.now();
      Fluttertoast.showToast(
        msg: LocalizationIntl.of(context).doubleBackToExitPrompt,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
      );
      return;
    }
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final tablet = isTabletWindow(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvoked,
      child: tablet ? _buildTablet(context) : _buildPhone(context),
    );
  }

  Widget _buildPhone(BuildContext context) {
    return Scaffold(
      body: _buildTabs(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildTablet(BuildContext context) {
    final split = useTabletSplitView(context);
    final showBottomNav = !split && !_detailCanPop && !_masterCanPop;
    return TabletSplitScope(
      detailKey: _detailNavKey,
      child: Scaffold(
        body: split ? _buildSplit(context) : _buildTabletPortrait(),
        bottomNavigationBar: showBottomNav ? _buildBottomNavigationBar(context) : null,
      ),
    );
  }

  Widget _buildSplit(BuildContext context) {
    return Row(
      children: [
        _buildRail(context),
        Expanded(
          flex: 2,
          child: ClipRect(
            child: AdaptivePane(
              child: _masterNav,
            ),
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
          color: Theme.of(context).dividerColor,
        ),
        Expanded(
          flex: 3,
          child: ClipRect(
            child: AdaptivePane(
              safeRight: true,
              child: _detailNav,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletPortrait() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _masterNav,
        Offstage(
          offstage: !_detailCanPop,
          child: _detailNav,
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      controller: _pageController,
      itemCount: _pages.length,
      itemBuilder: (BuildContext context, int index) {
        return _pages[index];
      },
    );
  }

  Widget _createMasterNavigator() {
    return Navigator(
      key: _masterNavKey,
      observers: [_masterObserver],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            if (settings.name == null || settings.name == Navigator.defaultRouteName) {
              return _buildTabs();
            }
            return _pageFor(context, settings);
          },
        );
      },
    );
  }

  Widget _createDetailNavigator() {
    return Navigator(
      key: _detailNavKey,
      observers: [_detailObserver],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            if (settings.name == null || settings.name == Navigator.defaultRouteName) {
              return const _DetailPlaceholder();
            }
            return _pageFor(context, settings);
          },
        );
      },
    );
  }

  Widget _pageFor(BuildContext context, RouteSettings settings) {
    final builder = Routes.match(context, settings.name);
    return builder(context, settings.arguments);
  }

  Widget _buildRail(BuildContext context) {
    final l10n = LocalizationIntl.of(context);
    final primary = Theme.of(context).primaryColor;
    return SafeArea(
      right: false,
      child: NavigationRail(
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedIndex: _currentIndex,
        onDestinationSelected: _selectTab,
        labelType: NavigationRailLabelType.all,
        groupAlignment: -0.85,
        selectedIconTheme: IconThemeData(color: primary),
        selectedLabelTextStyle: TextStyle(color: primary, fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelTextStyle: const TextStyle(fontSize: 12),
        destinations: [
          NavigationRailDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: Text(l10n.navHome),
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.widgets_outlined),
            selectedIcon: const Icon(Icons.widgets_rounded),
            label: Text(l10n.navDiscover),
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.explore_outlined),
            selectedIcon: const Icon(Icons.explore_rounded),
            label: Text(l10n.navDynamic),
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(Icons.person_rounded),
            label: Text(l10n.navProfile),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home_rounded),
          label: LocalizationIntl.of(context).navHome,
          tooltip: LocalizationIntl.of(context).navHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.widgets_outlined),
          activeIcon: const Icon(Icons.widgets_rounded),
          label: LocalizationIntl.of(context).navDiscover,
          tooltip: LocalizationIntl.of(context).navDiscover,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.explore_outlined),
          activeIcon: const Icon(Icons.explore_rounded),
          label: LocalizationIntl.of(context).navDynamic,
          tooltip: LocalizationIntl.of(context).navDynamic,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline_rounded),
          activeIcon: const Icon(Icons.person_rounded),
          label: LocalizationIntl.of(context).navProfile,
          tooltip: LocalizationIntl.of(context).navProfile,
        ),
      ],
      unselectedFontSize: 10,
      selectedFontSize: 10,
      fixedColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).colorScheme.surface,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: _selectTab,
    );
  }
}

class _DetailPlaceholder extends StatelessWidget {
  const _DetailPlaceholder();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45);
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.photo_outlined, size: 72, color: color),
              const SizedBox(height: 16),
              Text(
                LocalizationIntl.of(context).tabletDetailPlaceholder,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavSyncObserver extends NavigatorObserver {
  _NavSyncObserver({required this.onChanged});

  final VoidCallback onChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onChanged();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onChanged();
    if (route is TransitionRoute) {
      final animation = route.animation;
      if (animation == null) return;
      void listener(AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          animation.removeStatusListener(listener);
          onChanged();
        }
      }

      animation.addStatusListener(listener);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onChanged();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    onChanged();
  }
}
