import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

/// 通过该函数构建一个报错时显示的组件，当图片加载失败的时候才会显示，例如经典的404 NotFound。
typedef LoadingErrorWidgetBuilder = Widget Function(
  BuildContext context,
  String url,
  dynamic error,
);

/// 通过该函数构建一个加载过程中显示的组件
typedef LoadingProgressWidgetBuilder = Widget Function(
  BuildContext context,
  String url,
  ImageChunkEvent progress,
);

/// 拓展[ImageChunkEvent]，实现直接获取图片加载进度进度的占比
extension ExtensionImageChunkEvent on ImageChunkEvent {
  double? get progress {
    // ignore: avoid_returning_null
    if (expectedTotalBytes == null || cumulativeBytesLoaded > expectedTotalBytes!) return null;
    return cumulativeBytesLoaded / expectedTotalBytes!;
  }
}

/// 增强功能的网络图片组件，基于[ExtendedImage]
class EnhanceNetworkImage extends StatefulWidget {
  final ExtendedNetworkImageProvider image;

  final double? width;

  final double? height;

  final BoxFit? fit;

  /// Image加载失败时显示的组件
  final LoadingErrorWidgetBuilder? errorWidget;

  /// Image加载中时显示的组件
  final LoadingProgressWidgetBuilder? loadingWidget;

  // final Duration fadeOutDuration;

  // final Curve fadeOutCurve;

  /// 淡入持续时间
  final Duration fadeInDuration;

  /// Animation curve.
  final Curve fadeInCurve;

  /// If non-null, this color is blended with each image pixel using [colorBlendMode].
  final Color? color;

  /// Used to combine [color] with this image.
  final BlendMode? colorBlendMode;

  /// Used to set the [FilterQuality] of the image.
  final FilterQuality filterQuality;

  /// How to align the image within its bounds.
  final AlignmentGeometry alignment;

  /// if true, chear memory cache in disposed.
  final bool clearMemoryCacheWhenDispose;

  const EnhanceNetworkImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.alignment = Alignment.center,
    this.errorWidget,
    this.loadingWidget,
    this.clearMemoryCacheWhenDispose = true,
    // this.fadeOutDuration = const Duration(milliseconds: 1000),
    // this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
  });

  @override
  State<StatefulWidget> createState() => _EnhanceNetworkImageState();
}

class _EnhanceNetworkImageState extends State<EnhanceNetworkImage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: widget.fadeInDuration,
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController.drive(CurveTween(curve: Curves.decelerate)).drive(Tween(begin: 0, end: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage(
      image: widget.image,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.cover,
      alignment: widget.alignment,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      filterQuality: widget.filterQuality,
      opacity: _opacityAnimation,
      clearMemoryCacheWhenDispose: widget.clearMemoryCacheWhenDispose,
      enableLoadState: false,
      handleLoadingProgress: true,
      loadStateChanged: ((state) {
        // 不同的状态显示不同的组件
        switch (state.extendedImageLoadState) {
          case LoadState.completed:
            _animate();
            return null;
          case LoadState.failed:
            return widget.errorWidget != null
                ? widget.errorWidget!(context, widget.image.url, state.lastStack)
                : _buildDefaultErrorWidget(context);
          case LoadState.loading:
            return widget.loadingWidget != null
                ? widget.loadingWidget!(
                    context,
                    widget.image.url,
                    state.loadingProgress ?? const ImageChunkEvent(cumulativeBytesLoaded: 0, expectedTotalBytes: null),
                  )
                : null;
        }
      }),
    );
  }

  /// 默认的加载失败显示的组件
  Widget _buildDefaultErrorWidget(BuildContext context) {
    return const Center(
      child: Icon(Icons.error_outline_rounded),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animate() {
    if (_animationController.isAnimating) return;
    _animationController.animateTo(1.0, duration: widget.fadeInDuration, curve: widget.fadeInCurve);
  }
}
