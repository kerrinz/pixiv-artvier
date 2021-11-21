import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/pages/artworks/download_task_tabpage.dart';

class DownloadManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DownloadManagePageState();
}

class DownloadManagePageState extends State<DownloadManagePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              title: Text("我的下载"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, "setting_download");
                  },
                  tooltip: "下载设置",
                ),
              ],
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                isScrollable: false,
                tabs: [
                  Tab(text: "下载中"),
                  Tab(text: "已完成"),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            DownloadTaskTabPage(),
            DownloadTaskTabPage(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);

  }
}
