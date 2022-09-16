import 'dart:async';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_store/downloading_illust.dart';
import 'package:pixgem/pages/illust/illust_detail/illust_detail_page.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/store/download_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:pixgem/util/save_image_util.dart';
import 'package:provider/provider.dart';
import 'download_manage_provider.dart';

class DownloadManagePage extends StatefulWidget {
  const DownloadManagePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DownloadManagePageState();
}

class DownloadManagePageState extends State<DownloadManagePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final DownloadManageProvider _downloadManageProvider = DownloadManageProvider();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _downloadManageProvider.setDownloadingIllusts(DownloadStore.getDownloadedIllusts());
    _downloadManageProvider.setDownloadedIllusts(DownloadStore.getDownloadedIllusts());
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
      body: ChangeNotifierProvider(
        create: (BuildContext context) => _downloadManageProvider,
        child: ExtendedNestedScrollView(
          onlyOneScrollInBody: true,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: false,
                title: const Text("我的下载"),
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
              Selector(
                builder: (BuildContext context, Map<String, DownloadingIllust> map, Widget? child) =>
                    _buildDownloadingList(map),
                selector: (context, DownloadManageProvider provider) => GlobalStore.globalProvider.downloadingIllust,
              ),
              Selector(
                builder: (BuildContext context, List<CommonIllust> list, Widget? child) => _buildDownloadedList(list),
                selector: (context, DownloadManageProvider provider) => provider.downloadedIllusts,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建下载中的列表
  Widget _buildDownloadingList(Map<String, DownloadingIllust> map) {
    var illusts = map.values.toList();
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(illusts[index].illust.title,
                            style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary)),
                        Text("id: ${illusts[index].illust.id.toString()}"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 6),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.blue,
                      value: illusts[index].percentage,
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
                          arguments: ArtworkDetailModel(
                              list: [illusts[index].illust], index: 0, callback: (index, isBookmarked) {}));
                    },
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 8,
                child: InkWell(
                  onTap: () {
                    if (illusts[index].status == DownloadingStatus.failed) {
                      String url = map.keys.elementAt(index);
                      SaveImageUtil.saveIllustToGallery(illusts[index].illust, url);
                      GlobalStore.globalProvider.downloadingIllust[url]!.status = DownloadingStatus.downloading;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(builder: (context) {
                      return Column(
                        children: [
                          (illusts[index].status == DownloadingStatus.failed) ? const Icon(Icons.replay) : Container(),
                          Text("${(illusts[index].percentage * 100).toStringAsFixed(0)}%"),
                        ],
                      );
                      // switch (illusts[index].status) {
                      //   case DownloadingStatus.pause:
                      //     return Icon(Icons.download_rounded);
                      //   case DownloadingStatus.failed:
                      //     return Icon(Icons.replay_rounded);
                      //   default:
                      //     return Icon(Icons.pause_rounded);
                      // }
                    }),
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
                        arguments: ArtworkDetailModel(list: illusts, index: index, callback: (index, isBookmarked) {}),
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
