import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 构建 [AppBar] 的函数
///
/// [offset] 垂直方向的偏移量
typedef AppBarBuilder = Widget Function(double offset);

class BannerAppBarPageLayout extends ConsumerStatefulWidget {
  const BannerAppBarPageLayout({
    super.key,
    required this.appBarBuilder,
    this.bannerWidget,
    this.bannerHeight,
    required this.appBarStartBuilderOffset,
    required this.appBarEndBuilderOffset,
    required this.body,
    this.scrollController,
  }) : assert((bannerWidget == null && bannerHeight == null) || (bannerWidget != null && bannerHeight != null));

  final ScrollController? scrollController;

  final AppBarBuilder appBarBuilder;

  /// 封面图区域的Widget，其管理状态可在内部自行实现
  final Widget? bannerWidget;

  /// 主体内容，需要自行添加的padding-top，以避免遮挡banner
  ///
  /// （为了更高的自由度，例如自由定制R角）
  final Widget body;

  /// 封面图高度（仅用于滚动计算，不影响实际组件高度）
  final double? bannerHeight;

  /// AppBar开始实时构建时，所处的垂直滚动位置
  final double appBarStartBuilderOffset;

  /// AppBar结束实时构建时，所处的垂直滚动位置
  ///
  /// （为了减少不必要的rebuild开销，故没有全程调用[appBarBuilder]去构建）
  final double appBarEndBuilderOffset;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BannerAppBarPageLayoutState();
}

class _BannerAppBarPageLayoutState extends ConsumerState<BannerAppBarPageLayout> {
  late ScrollController _scrollController;

  /// 是否已经挂载了监听事件
  bool _hasMountedListener = false;

  /// 背景封面图的高度
  double? get _bannerHeight => widget.bannerHeight;

  /// 用于AppBar构建的滚动位置监听器
  final ValueNotifier<double> _appBarOffsetNotifier = ValueNotifier<double>(0);

  /// 封面图区域的垂直偏移量
  final ValueNotifier<double> _bannerffsetNotifier = ValueNotifier<double>(0);

  double get _start => widget.appBarStartBuilderOffset;
  double get _end => widget.appBarEndBuilderOffset;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasMountedListener) {
      _scrollController = widget.scrollController ?? PrimaryScrollController.of(context);
      _scrollController.addListener(_handleScroll);
      _hasMountedListener = true;
    }
  }

  // 滚动事件
  void _handleScroll() {
    // 更新AppBar构建所需要的偏移量
    double offset = _scrollController.offset;
    if (offset >= _end) {
      if (_appBarOffsetNotifier.value != _end) _appBarOffsetNotifier.value = _end;
    } else if (offset <= _start) {
      if (_appBarOffsetNotifier.value != _start) _appBarOffsetNotifier.value = _start;
    } else {
      _appBarOffsetNotifier.value = offset;
    }
    // 更新banner的位置
    if (_bannerHeight != null) {
      if (offset > _bannerHeight!) {
        if (_bannerffsetNotifier.value != _bannerHeight) _bannerffsetNotifier.value = _bannerHeight!;
      } else {
        _bannerffsetNotifier.value = offset;
      }
    }
  }

  @override
  void dispose() {
    if (_scrollController.hasClients) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 顶部封面图
        if (widget.bannerWidget != null)
          ValueListenableBuilder<double>(
              valueListenable: _bannerffsetNotifier,
              builder: (_, value, __) {
                return Transform.translate(
                  offset: Offset(0, -value),
                  child: SizedBox(
                    width: double.infinity,
                    height: _bannerHeight,
                    child: widget.bannerWidget,
                  ),
                );
              }),
        // 主体内容
        widget.body,
        // 固定顶部的AppBar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder<double>(
              valueListenable: _appBarOffsetNotifier,
              builder: (_, value, __) {
                return widget.appBarBuilder(value);
              }),
        ),
      ],
    );
  }
}
