import 'dart:async';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/global/model/image_download_task_model/image_download_task_model.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/routes.dart';

class DownloadManagePage extends BaseStatefulPage {
  const DownloadManagePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DownloadManagePageState();
}

/// TODO: 下载功能需要引入数据库后再开发，以下代码几乎半废
class DownloadManagePageState extends BasePageState<DownloadManagePage> with TickerProviderStateMixin {
  late TabController _tabController;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              title: const Text("我的下载"),
              toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.downloadSettings.name);
                  },
                  tooltip: "下载设置",
                ),
              ],
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                isScrollable: false,
                tabs: const [
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
            _buildDownloadingList([]),
            _buildDownloadedList([]),
          ],
        ),
      ),
    );
  }

  // 构建下载中的列表
  Widget _buildDownloadingList(List<ImageDownloadTaskModel> list) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        var item = list[index];
        double progress = item.totalBytes == null ? 0 : (item.receivedBytes ?? 0 / item.totalBytes!);
        return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary)),
                        Text("id: ${item.worksId}"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 6),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.blue,
                      value: progress,
                      minHeight: 1,
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.black12.withOpacity(0.15),
                    highlightColor: Colors.black12.withOpacity(0.1),
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteNames.artworkDetail.name,
                          arguments: IllustDetailPageArguments(illustId: item.worksId));
                    },
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 8,
                child: InkWell(
                  onTap: () {
                    // if (DownloadState.failed) {}
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(builder: (context) {
                      return Column(
                        children: [
                          (item.downloadState == 4) ? const Icon(Icons.replay) : Container(),
                          Text("${(progress * 100).toStringAsFixed(0)}%"),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: list.length,
    );
  }

  // 构建已完成的列表
  Widget _buildDownloadedList(List<CommonIllust> illusts) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(illusts[index].title,
                              style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary)),
                          Text("id: ${illusts[index].id.toString()}"),
                        ],
                      ),
                    ),
                    const Icon((Icons.arrow_right_rounded)),
                  ],
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.black12.withOpacity(0.15),
                    highlightColor: Colors.black12.withOpacity(0.1),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteNames.artworkDetail.name,
                        arguments: IllustDetailPageArguments(
                          detail: illusts[index],
                          illustId: illusts[index].id.toString(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: illusts.length,
    );
  }
}
