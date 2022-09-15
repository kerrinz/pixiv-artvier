/* APP主体内容框架：分页框架 （APP视觉上的起始页面）*/
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/pages/main_navigation_tab_page/home/home_tabpage.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/profile_tabpage.dart';
import 'package:pixgem/pages/main_navigation_tab_page/newest/newest_tabpage.dart';
import 'package:pixgem/pages/main_navigation_tab_page/search/search_tabpage.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainNavigationState();
  }
}

class MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0; // 当前分页
  // 分页组
  final List<Widget> _pages = [
    const HomePage(),
    const SearchTabPage(),
    const NewArtworksTabPage(),
    const ProfileTabPage(),
  ];
  final PageController _pageController = PageController();
  DateTime? _lastPressedBack; // 上次点击返回的时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 拦截短时间内的单按返回
        if (_lastPressedBack == null || DateTime.now().difference(_lastPressedBack!) > const Duration(seconds: 1)) {
          // 两次点击间隔超过1秒则重新计时
          _lastPressedBack = DateTime.now();
          Fluttertoast.showToast(
              msg: LocalizationIntl.of(context).doubleBackToExitPrompt, toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
          return false;
        }
        // 短时间内双击返回加通过
        return true;
      },
      child: Scaffold(
        body: PageView.builder(
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: LocalizationIntl.of(context).navHome,
                tooltip: LocalizationIntl.of(context).navHome),
            BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: LocalizationIntl.of(context).navDiscover,
                tooltip: LocalizationIntl.of(context).navDiscover),
            BottomNavigationBarItem(
                icon: const Icon(Icons.bookmark),
                label: LocalizationIntl.of(context).navDynamic,
                tooltip: LocalizationIntl.of(context).navDynamic),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: LocalizationIntl.of(context).navProfile,
                tooltip: LocalizationIntl.of(context).navProfile),
          ],
          fixedColor: Theme.of(context).colorScheme.primary,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index) {
            // 切换页面
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
