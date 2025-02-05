import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/artwork/viewer/logic.dart';
import 'package:artvier/pages/artwork/viewer/model/image_quality_url_model.dart';
import 'package:artvier/pages/artwork/viewer/model/image_viewer_page_arguments.dart';

/// 图片浏览
class ImageViewerPage extends BaseStatefulPage {
  final ImageViewerPageArguments arguments;

  const ImageViewerPage(Object arg, {super.key}) : arguments = arg as ImageViewerPageArguments;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ImageViewerPageState();
  }
}

class _ImageViewerPageState extends BasePageState<ImageViewerPage>
    with SingleTickerProviderStateMixin, ImageViewerPageLogic {
  late PageController _pageController;

  @override
  List<ImageQualityUrl> get urlList => widget.arguments.urlList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.arguments.index);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    Consumer(
                      builder: (_, ref, __) {
                        var pageIndex = ref.watch(imageViewerProvider.select((value) => value.pageIndex));
                        return Text("${pageIndex + 1}/${urlList.length}", style: const TextStyle(fontSize: 18));
                      },
                    ),
                    // 其他功能键
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.file_download),
                            onPressed: () async => handlePressedDownload(
                              ref.read(imageViewerProvider.select((value) => value.pageIndex)),
                            ),
                            tooltip: "下载",
                            color: Colors.white,
                            iconSize: 26,
                          ),
                          Consumer(
                            builder: (_, ref, __) {
                              var isOriginal = ref.watch(imageViewerProvider.select((value) => value.isOriginal));
                              return IconButton(
                                icon: Icon(isOriginal ? Icons.hd : Icons.hd_outlined),
                                onPressed: () => ref
                                    .read(imageViewerProvider.notifier)
                                    .update((state) => state.copyWith(isOriginal: !isOriginal)),
                                tooltip: isOriginal ? "切换到标清" : "切换到原图",
                                color: Colors.white,
                                iconSize: 26,
                              );
                            },
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
    );
  }

  Widget _buildPreviewImage(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Consumer(
          builder: (_, ref, __) {
            var state = ref.watch(imageViewerProvider);
            return PhotoViewGallery.builder(
              allowImplicitScrolling: true,
              gaplessPlayback: true,
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: ExtendedNetworkImageProvider(
                    HttpHostOverrides().pxImgUrl(state.isOriginal ? urlList[index].original : urlList[index].normal),
                    headers: HttpHostOverrides().pximgHeaders,
                  ),
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  maxScale: PhotoViewComputedScale.contained * 5.0,
                );
              },
              itemCount: urlList.length,
              pageController: _pageController,
              onPageChanged: (int index) =>
                  ref.read(imageViewerProvider.notifier).update((state) => state.copyWith(pageIndex: index)),
              loadingBuilder: (context, progress) => const Center(
                child: Center(child: CircularProgressIndicator(strokeWidth: 1.0)),
              ),
            );
          },
        ),
      ),
    );
  }
}
