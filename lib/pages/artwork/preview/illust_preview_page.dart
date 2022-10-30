import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/store/download_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:pixgem/util/save_image_util.dart';
import 'package:provider/provider.dart';

import 'preview_provider.dart';

/*
* 传入参数：List<CommonIllust>
* */
class PreviewArtworksPage extends StatefulWidget {
  late final CommonIllust illust; // 图片集合，每张图片有标清和高清两种模式

  PreviewArtworksPage(Object arguments, {Key? key}) : super(key: key) {
    illust = arguments as CommonIllust;
  }

  @override
  State<StatefulWidget> createState() {
    return _PreviewArtworksState();
  }
}

class _PreviewArtworksState extends State<PreviewArtworksPage> with SingleTickerProviderStateMixin {
  late PageController mController;
  final PreviewProvider _provider = PreviewProvider();
  late final Permission _permission = Permission.storage;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  late List<Image_urls> imageUrls;

  @override
  void initState() {
    super.initState();
    imageUrls = getIllustUrls();
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
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  // 阴影渐变
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0x0d000000),
                      Color(0x80000000),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // 返回
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        onPressed: () => Navigator.pop(context),
                        tooltip: "关闭",
                        color: Colors.white,
                        iconSize: 26,
                      ),
                      // 页码显示
                      Selector(
                        builder: (BuildContext context, int page, Widget? child) =>
                            Text("${page + 1}/${imageUrls.length}", style: const TextStyle(fontSize: 18)),
                        selector: (context, PreviewProvider provider) => provider.currentPage,
                      ),
                      // 其他功能键
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.file_download),
                              onPressed: () async {
                                bool isPermit = await checkPermissions();
                                if (!isPermit) return; // 没权限，不下载
                                switch (GlobalStore.globalProvider.downloadMode) {
                                  case DownloadStore.MODE_DOWNLOAD_PATH:
                                    Fluttertoast.showToast(
                                        msg: "下载到./Download", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                                    break;
                                  case DownloadStore.MODE_CUSTOM:
                                    Fluttertoast.showToast(
                                        msg: "自定义保存路径", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                                    break;
                                  default:
                                    // 保存图片到相册
                                    await SaveImageUtil.saveIllustToGallery(
                                      widget.illust,
                                      imageUrls[_provider.currentPage].original ??
                                          imageUrls[_provider.currentPage].large,
                                    );
                                }
                              },
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
                              selector: (context, PreviewProvider provider) => provider.isHdMode,
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
    return SizedBox(
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
                      isHdMode ? imageUrls[index].original ?? imageUrls[index].original! : imageUrls[index].large,
                      headers: {"referer": CONSTANTS.referer}),
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  maxScale: PhotoViewComputedScale.contained * 5.0,
                );
              },
              itemCount: imageUrls.length,
              pageController: mController,
              onPageChanged: (int index) => _provider.setCurrentPage(index),
              loadingBuilder: (context, progress) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: Text("========================"),
                ),
              ),
            );
          },
          selector: (context, PreviewProvider provider) {
            return provider.isHdMode;
          },
        ),
      ),
    );
  }

  // 检查权限，没权限会自动跳转app权限管理页
  Future<bool> checkPermissions() async {
    if (Platform.isIOS) {
      _permissionStatus = await Permission.photosAddOnly.request();
      if (_permissionStatus.isPermanentlyDenied) {
        openAppSettings(); // 权限被拒绝，跳转设置
        return false;
      }
    } else if (Platform.isAndroid) {
      //发起权限申请
      _permissionStatus = await _permission.request();
      if (_permissionStatus.isPermanentlyDenied) {
        openAppSettings(); // 权限被拒绝，跳转设置
        return false;
      }
    }
    return true;
  }

  // 统一方法，获取展示的图片url列表
  List<Image_urls> getIllustUrls() {
    var detail = widget.illust;
    List<Image_urls> result = [];
    // 传参
    if (detail.metaPages.isEmpty) {
      detail.imageUrls.original = detail.metaSinglePage.originalImageUrl;
      result = [detail.imageUrls];
    } else {
      // 草了这辣鸡接口
      for (var element in detail.metaPages) {
        result.add(element.imageUrls);
      }
    }
    return result;
  }
}
