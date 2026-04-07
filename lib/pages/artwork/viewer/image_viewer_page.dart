import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/artwork/viewer/logic.dart';
import 'package:artvier/pages/artwork/viewer/model/image_quality_url_model.dart';
import 'package:artvier/pages/artwork/viewer/model/image_viewer_page_arguments.dart';
import 'package:artvier/pages/artwork/viewer/model/original_load_status.dart';

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
  final Map<int, ImageStream> _originalImageStreams = {};
  final Map<int, ImageStreamListener> _originalImageListeners = {};

  @override
  List<ImageQualityUrl> get urlList => widget.arguments.urlList;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _pageController = PageController(initialPage: widget.arguments.index);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController.dispose();
    for (final entry in _originalImageStreams.entries) {
      final listener = _originalImageListeners[entry.key];
      if (listener != null) {
        entry.value.removeListener(listener);
      }
    }
    _originalImageStreams.clear();
    _originalImageListeners.clear();
    super.dispose();
  }

  /// 跟踪原图加载
  void _trackOriginalImageLoad(int index) {
    final status = ref.read(originalLoadProvider)[index] ?? const OriginalLoadStatus.idle();
    if (status.isLoaded || _originalImageStreams.containsKey(index)) return;

    final provider = ExtendedNetworkImageProvider(
      HttpHostOverrides().pxImgUrl(urlList[index].original),
      headers: HttpHostOverrides().pximgHeaders,
      cache: true,
    );
    final stream = provider.resolve(const ImageConfiguration());

    ref.read(originalLoadProvider.notifier).update((map) {
      final prev = map[index] ?? const OriginalLoadStatus.idle();
      return {
        ...map,
        index: prev.copyWith(isLoading: true, progress: prev.progress ?? 0, isLoaded: false),
      };
    });

    late final ImageStreamListener listener;
    listener = ImageStreamListener(
      (image, syncCall) {
        ref.read(originalLoadProvider.notifier).update((map) {
          return {
            ...map,
            index: const OriginalLoadStatus(isLoading: false, progress: 1, isLoaded: true),
          };
        });
        stream.removeListener(listener);
        _originalImageStreams.remove(index);
        _originalImageListeners.remove(index);
      },
      onChunk: (event) {
        final p = (event.expectedTotalBytes == null || event.expectedTotalBytes == 0)
            ? null
            : (event.cumulativeBytesLoaded / event.expectedTotalBytes!).clamp(0.0, 1.0);
        ref.read(originalLoadProvider.notifier).update((map) {
          final prev = map[index] ?? const OriginalLoadStatus.idle();
          return {
            ...map,
            index: prev.copyWith(isLoading: true, progress: p, isLoaded: false),
          };
        });
      },
      onError: (_, __) {
        ref.read(originalLoadProvider.notifier).update((map) {
          final prev = map[index] ?? const OriginalLoadStatus.idle();
          return {
            ...map,
            index: prev.copyWith(isLoading: false),
          };
        });
        stream.removeListener(listener);
        _originalImageStreams.remove(index);
        _originalImageListeners.remove(index);
      },
    );

    _originalImageStreams[index] = stream;
    _originalImageListeners[index] = listener;
    stream.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(child: Container(color: Colors.black)),
          // 预览图片
          _buildPreviewImage(context),
          // 底栏
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
                    Color(0x22000000),
                    Color(0xcc000000),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: SafeArea(
                  top: false,
                  bottom: true,
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
                            Consumer(
                              builder: (_, ref, __) {
                                final isOriginal = ref.watch(imageViewerProvider.select((value) => value.isOriginal));
                                final pageIndex = ref.watch(imageViewerProvider.select((value) => value.pageIndex));
                                final loadMap = ref.watch(originalLoadProvider);
                                final status = loadMap[pageIndex] ?? const OriginalLoadStatus.idle();

                                if (!isOriginal) {
                                  return TextButton(
                                    onPressed: () {
                                      // 开启全局原图模式：当前页立即开始加载原图
                                      ref
                                          .read(imageViewerProvider.notifier)
                                          .update((state) => state.copyWith(isOriginal: true));
                                      ref.read(originalLoadProvider.notifier).update((state) {
                                        return {
                                          ...state,
                                          pageIndex:
                                              const OriginalLoadStatus(isLoading: true, progress: 0, isLoaded: false),
                                        };
                                      });
                                      _trackOriginalImageLoad(pageIndex);
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      minimumSize: const Size(0, 40),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      "查看原图",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                  );
                                }

                                if (status.isLoaded) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "已加载原图",
                                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                  );
                                }

                                final progress = status.progress;
                                final percent =
                                    progress == null ? null : (progress * 100).clamp(0, 100).toStringAsFixed(0);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: progress,
                                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        percent == null ? "原图加载中" : "$percent% 原图加载中",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.file_download),
                              onPressed: () async => handlePressedDownload(
                                ref.read(imageViewerProvider.select((value) => value.pageIndex)),
                              ),
                              tooltip: "下载",
                              color: Colors.white,
                              iconSize: 26,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
      child: Consumer(
        builder: (_, ref, __) {
          var state = ref.watch(imageViewerProvider);
          return PhotoViewGallery.builder(
            allowImplicitScrolling: true,
            gaplessPlayback: true,
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: urlList.length,
            pageController: _pageController,
            onPageChanged: (index) {
              ref.read(imageViewerProvider.notifier).update((state) => state.copyWith(pageIndex: index));

              // 开启原图模式后：翻到哪张才触发哪张的原图加载状态（用于底栏进度展示）
              final s = ref.read(imageViewerProvider);
              if (s.isOriginal) {
                ref.read(originalLoadProvider.notifier).update((map) {
                  final prev = map[index] ?? const OriginalLoadStatus.idle();
                  if (prev.isLoaded || prev.isLoading) return map;
                  return {
                    ...map,
                    index: const OriginalLoadStatus(isLoading: true, progress: 0, isLoaded: false),
                  };
                });
                _trackOriginalImageLoad(index);
              }
            },
            builder: (BuildContext context, int index) {
              final loadMap = ref.watch(originalLoadProvider);
              final status = loadMap[index] ?? const OriginalLoadStatus.idle();
              final shouldUseOriginal =
                  state.isOriginal && (index == state.pageIndex || status.isLoading || status.isLoaded);
              final imgUrl = HttpHostOverrides().pxImgUrl(
                  shouldUseOriginal ? urlList[index].original : urlList[index].normal ?? urlList[index].original);
              return PhotoViewGalleryPageOptions(
                  onTapUp: (_, __, ___) => Navigator.pop(context),
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  maxScale: PhotoViewComputedScale.contained * 5.0,
                  imageProvider: ExtendedNetworkImageProvider(
                    imgUrl,
                    headers: HttpHostOverrides().pximgHeaders,
                    cache: true,
                  ),
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          (context as Element).markNeedsBuild();
                        },
                        child: Text("加载失败，点击重试"),
                      ),
                    );
                  });
            },
            // 加载时显示 loading 图标
            loadingBuilder: (context, event) {
              double progress = event?.expectedTotalBytes != null
                  ? ((event?.cumulativeBytesLoaded.toDouble() ?? 0) / event!.expectedTotalBytes!.toDouble())
                  : 0.0;
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      // strokeWidth: 4.0,
                      value: progress,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("${(progress * 100).toStringAsFixed(0)}%"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
