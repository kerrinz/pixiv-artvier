import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:provider/provider.dart';

/*
* 传入参数：List<ArtworksImageUrls>
* */
class PreviewArtworksPage extends StatefulWidget {
  late final List<Image_urls> urlList; // 图片集合，每张图片有标清和高清两种模式

  PreviewArtworksPage(Object arguments, {Key? key}) : super(key: key) {
    urlList = arguments as List<Image_urls>;
  }

  @override
  State<StatefulWidget> createState() {
    return _PreviewArtworksState();
  }
}

class _PreviewArtworksState extends State<PreviewArtworksPage> with SingleTickerProviderStateMixin {
  late PageController mController;
  _PreviewProvider _provider = _PreviewProvider();

  @override
  void initState() {
    super.initState();
    mController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => _provider,
        child: Stack(
          children: [
            Positioned(child: Container(color: Colors.black)),
            _buildPreviewImage(context),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Material(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  // 阴影渐变
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xD000000),
                      Color(0x80000000),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // 返回
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_rounded),
                        onPressed: () => Navigator.pop(context),
                        tooltip: "关闭",
                        color: Colors.white,
                        iconSize: 26,
                      ),
                      // 页码显示
                      Selector(
                        builder: (BuildContext context, int page, Widget? child) =>
                            Text("${page + 1}/${widget.urlList.length}", style: TextStyle(fontSize: 18)),
                        selector: (context, _PreviewProvider provider) => provider.currentPage,
                      ),
                      // 其他功能键
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.file_download),
                              onPressed: () {},
                              tooltip: "下载",
                              color: Colors.white,
                              iconSize: 26,
                            ),
                            Selector(
                              builder: (BuildContext context, bool isHdMode, Widget? child) => IconButton(
                                icon: Icon(isHdMode ? Icons.hd : Icons.hd_outlined),
                                onPressed: () => _provider.setHdMode(!isHdMode),
                                tooltip: isHdMode ? "切换到标清模式" : "切换到高清/原图模式",
                                color: Colors.white,
                                iconSize: 26,
                              ),
                              selector: (context, _PreviewProvider provider) => provider.isHdMode,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewImage(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Selector(
          builder: (BuildContext context, bool isHdMode, Widget? child) {
            return PhotoViewGallery.builder(
              allowImplicitScrolling: true,
              gaplessPlayback: true,
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(
                      isHdMode
                          ? widget.urlList[index].original ?? widget.urlList[index].large
                          : widget.urlList[index].large,
                      headers: {"referer": CONSTANTS.referer}),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.contained * 2,
                );
              },
              itemCount: widget.urlList.length,
              pageController: mController,
              onPageChanged: (int index) => _provider.setCurrentPage(index),
              // loadingBuilder: (context, progress) => Center(
              //   child: Container(
              //     width: 20.0,
              //     height: 20.0,
              //     child: CircularProgressIndicator(
              //       value: _progress == null ? null : _progress.cumulativeBytesLoaded / _progress.expectedTotalBytes,
              //     ),
              //   ),
              // ),
            );
          },
          selector: (context, _PreviewProvider provider) {
            return provider.isHdMode;
          },
        ),
      ),
    );
  }
}

class _PreviewProvider with ChangeNotifier {
  bool isHdMode = false; // 是否高清模式
  int currentPage = 0; // 当前页

  void setHdMode(bool isHdMode) {
    this.isHdMode = isHdMode;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    this.currentPage = page;
    notifyListeners();
  }
}
