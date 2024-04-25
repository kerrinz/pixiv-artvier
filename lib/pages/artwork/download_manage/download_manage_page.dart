import 'dart:async';

import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/artwork/download_manage/provider/download_manage_provider.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/routes.dart';

class DownloadManagePage extends BaseStatefulPage {
  const DownloadManagePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DownloadManagePageState();
}

class DownloadManagePageState extends BasePageState<DownloadManagePage> with TickerProviderStateMixin {
  late final Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      ref.read(downloadTaskQueueProvider.notifier).reloadState();
    });
    super.initState();
  }

  @override
  void dispose() {
    // 取消定时器
    timer.cancel();
    super.dispose();
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
            ),
          ];
        },
        body: _buildDownloadList(),
      ),
    );
  }

  // 构建下载中的列表
  Widget _buildDownloadList() {
    var asyncValue = ref.watch(downloadTaskQueueProvider);
    return asyncValue.when(
      data: (downloadList) {
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: downloadList.length,
          itemBuilder: (BuildContext context, int index) {
            var item = downloadList[index];
            double progress = item.totalBytes <= 0 ? 0 : (item.receivedBytes / item.totalBytes);
            return Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: textTheme.titleMedium),
                              Text("id: ${item.worksId}"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Builder(builder: (context) {
                          switch (item.status) {
                            case DownloadState.success:
                              return const Icon(Icons.check, color: Colors.green);
                            case DownloadState.waiting:
                              return const Opacity(opacity: 0.5, child: Icon(Icons.access_time));
                            case DownloadState.failed:
                              return const Icon(Icons.error, color: Colors.red);
                            default:
                              return Text("${(progress * 100).toStringAsFixed(0)}%");
                          }
                        }),
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
                  // Positioned(
                  //   right: 0,
                  //   bottom: 0,
                  //   child: InkWell(
                  //     onTap: () {
                  //       // Retry
                  //     },
                  //   ),
                  // ),
                ],
              ),
            );
          },
        );
      },
      error: (error, stackTrace) => LazyloadingFailedWidget(
        onRetry: (() {
          /// TODO: 加载失败的界面
        }),
      ),
      loading: (() => const LazyloadingWidget()),
    );
  }
}
