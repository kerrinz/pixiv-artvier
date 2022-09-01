
/* APP主体内容框架：分页框架 （APP视觉上的起始页面）*/
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/pages/main_navigation_tab_page/home/home_tabpage.dart';
import 'package:pixgem/pages/main_navigation_tab_page/mine/mine_tabpage.dart';
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
    const MineTabPage(),
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
          Fluttertoast.showToast(msg: "双击退出程序", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页", tooltip: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "发现", tooltip: "发现"),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "动态", tooltip: "动态"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的", tooltip: "我的"),
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
