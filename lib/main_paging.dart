
/* APP主体内容框架：分页框架 （APP视觉上的起始页面）*/
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'pages/home_navigation_tab_pages/home_tabpage.dart';
import 'pages/home_navigation_tab_pages/mine_tabpage.dart';
import 'pages/home_navigation_tab_pages/new_artworks_tabpage.dart';
import 'pages/home_navigation_tab_pages/search_tabpage.dart';

class MainPaging extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPagingState();
  }
}

class MainPagingState extends State<MainPaging> {
  int _currentIndex = 0; // 当前分页
  // 分页组
  List<Widget> _pages = [
    HomePage(),
    NewArtworksTabPage(),
    SearchTabPage(),
    MineTabPage(),
  ];
  PageController _pageController = PageController();
  DateTime? _lastPressedBack; // 上次点击返回的时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 拦截短时间内的单按返回
        if (_lastPressedBack == null || DateTime.now().difference(_lastPressedBack!) > Duration(seconds: 1)) {
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
              this._currentIndex = index;
            });
          },
          controller: _pageController,
          itemCount: _pages.length,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index];
          },
        ),
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页", tooltip: "首页"),
              BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "新作/发现", tooltip: "新作"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "搜索", tooltip: "搜索"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的", tooltip: "我的"),
            ],
            fixedColor: Theme.of(context).colorScheme.secondary,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (int index) {
              // 切换页面
              _pageController.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }
}
