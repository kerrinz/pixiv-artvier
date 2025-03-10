import 'package:artvier/business_component/input/search_box.dart';
import 'package:artvier/component/tab_view/tab_indicator.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/views/home_illust_tabpage.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/views/home_manga_tabpage.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/views/home_novel_tabpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';

class HomePage extends BaseStatefulPage {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends BasePageState with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final List<ScrollController> _scrollControllerList = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];

  /// Use to TabPage.
  late TabController _tabController;

  /// AppBar (background) opacity in scrolling.
  final ValueNotifier<double> _appbarOpacityNotifier = ValueNotifier(0.0);

  /// Changed TabPage index.
  int tabIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      tabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.depth == 1) {
              _appbarOpacityNotifier.value = getAppBarOpacity();
            }
            return true;
          },
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              if (notification.depth == 0) {
                _appbarOpacityNotifier.value = getAppBarOpacity();
              }
              return true;
            },
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomeIllustTabPage(scrollController: _scrollControllerList[0]),
                HomeMangaTabPage(scrollController: _scrollControllerList[1]),
                HomeNovelTabPage(scrollController: _scrollControllerList[2]),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder<double>(
            valueListenable: _appbarOpacityNotifier,
            builder: (BuildContext context, double value, Widget? child) {
              return _buildAppBar(value);
            },
          ),
        ),
      ],
    );
  }

  double getAppBarOpacity() {
    if (_tabController.index == 2) {
      // Novel tab.
      return 1;
    }
    final offset = _scrollControllerList[_tabController.index].offset;
    double opacity = 0.0;
    if (offset >= 200) {
      opacity = 1;
    } else if (offset >= 100) {
      opacity = (offset - 100) / 100;
    }
    return opacity;
  }

  /// Render AppBar
  Widget _buildAppBar(double opacity) {
    double bgOpacity = opacity;
    Color inputBackgroundColor = bgOpacity > 0.5 ? Colors.grey.withOpacity(0.15) : Colors.black12;
    Color textColor = Colors.white;
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light && (bgOpacity > 0.5 || tabIndex == 2)) {
      textColor = Colors.black;
    }
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 10, left: 10, right: 10),
      height: (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(bgOpacity),
      ),
      child: Row(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            padding: EdgeInsets.zero,
            labelStyle: textTheme.titleMedium?.copyWith(color: textColor, fontWeight: FontWeight.bold),
            unselectedLabelStyle: textTheme.titleMedium?.copyWith(color: textColor, fontWeight: FontWeight.normal),
            labelColor: textColor,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            unselectedLabelColor: textColor.withOpacity(0.8),
            indicator: CustomUnderlineTabIndicator(
              indicatorWidth: 16,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                width: 2,
                color: textColor,
              ),
            ),
            onTap: (index) {
              // Tap same tab to scroll to top.
              if (tabIndex == index) {
                final controller = _scrollControllerList[_tabController.index];
                controller.animateTo(0, duration: Durations.long1, curve: Curves.ease);
              }
              tabIndex = index;
            },
            tabs: [
              Tab(text: l10n.illust),
              Tab(text: l10n.manga),
              Tab(text: l10n.novels),
            ],
          ),
          Expanded(
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SearchBox(
                  textColor: textColor,
                  backgroundColor: inputBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var scrollController in _scrollControllerList) {
      if (scrollController.hasClients) {
        scrollController.dispose();
      }
    }
    super.dispose();
  }
}
