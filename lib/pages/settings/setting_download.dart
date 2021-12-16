import 'package:flutter/material.dart';
import 'package:pixgem/store/download_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class SettingDownload extends StatefulWidget {
  SettingDownload({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingDownloadState();
}

class SettingDownloadState extends State<SettingDownload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片保存方式"),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          // 这样解决了内容不足以支撑全屏时，滑动回弹不会回到原位的问题
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Selector(selector: (BuildContext context, GlobalProvider provider) {
                return provider.downloadMode;
              }, builder: (BuildContext context, int mode, Widget? child) {
                return Row(
                  children: [
                    _buildCard(mode),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // 切换亮度主题，例如暗黑模式
  Widget _buildCard(int mode) {
    return Expanded(
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          // side: BorderSide(width: 1, color: Colors.white),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (mode != DownloadStore.MODE_GALLERY)
                  GlobalStore.globalProvider.setDownloadMode(DownloadStore.MODE_GALLERY, true);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(child: Text("保存到系统相册（默认）", style: TextStyle(fontSize: 16))),
                    mode == DownloadStore.MODE_GALLERY
                        ? Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.secondary)
                        : Container(),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // if (mode != DownloadStore.MODE_DOWNLOAD_PATH)
                //   GlobalStore.globalProvider.setDownloadMode(DownloadStore.MODE_DOWNLOAD_PATH, true);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(child: Text("保存到下载文件夹：./Download（暂不支持）", style: TextStyle(fontSize: 16))),
                    mode == DownloadStore.MODE_DOWNLOAD_PATH
                        ? Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.secondary)
                        : Container(),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // if (mode != DownloadStore.MODE_CUSTOM)
                //   GlobalStore.globalProvider.setDownloadMode(DownloadStore.MODE_CUSTOM, true);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(child: Text("自定义保存路径（暂不支持）", style: TextStyle(fontSize: 16))),
                    mode == DownloadStore.MODE_CUSTOM
                        ? Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.secondary)
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
