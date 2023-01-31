import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/component/drag_view/drag_vertical_container.dart';

class ArtworkDetailPageLayout extends ConsumerStatefulWidget {
  const ArtworkDetailPageLayout({
    super.key,
    required this.appBar,
    required this.viewerContent,
    required this.bottomContentBuilder,
    this.isShapedScreen = false,
  });

  final Widget appBar;

  /// 图片的浏览区域
  final Widget viewerContent;

  /// 后半（底部）的拖拽区域
  final Widget Function(ScrollController scrollController) bottomContentBuilder;

  /// 手机屏幕是否异形屏
  ///
  /// true将会使得图片下移，以避免被手机的刘海、水滴等不可视区域遮挡
  final bool isShapedScreen;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArtworkDetailPageLayoutState();
}

class _ArtworkDetailPageLayoutState extends ConsumerState<ArtworkDetailPageLayout> {
  /// 拖拽组件内部滚动内容的控制器
  final ScrollController _scrollController = ScrollController();

  final DragController _dragController = DragController();

  double _scrollOffset = 0;

  double _minimunPosition = 50;

  late double _maximumPosition;

  /// 收藏按钮的高度偏移量
  static const double _floatingButtonOffset = 20;

  /// 拖拽组件最小内容高度
  static const double _minRevealHeight = 205;

  bool _isInit = true;

  /// 图片浏览区域的位移
  final _viewerOffsetProvider = StateProvider.autoDispose<double>((ref) => 0);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      _scrollOffset = _scrollController.offset;
      // 滚动到顶才允许拖拽
      if (_scrollController.offset > 0) {
        _dragController.setCanStopover(false);
      } else {
        _dragController.setCanStopover(true);
      }
    });
    _dragController.setDragListener((position, status) {
      // 更新图片浏览区域的位移量
      if (ref.read(_viewerOffsetProvider) != position) {
        ref.read(_viewerOffsetProvider.notifier).update((state) => (_maximumPosition - position) / 1.8);
      }
      // 保持滚动位置不变，直到拖拽组件视图最大化
      if (position != _minimunPosition) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollOffset);
        }
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _isInit = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double statusBarHeight = MediaQuery.of(context).padding.top; // 状态栏高度
      double toolBarHeight = Theme.of(context).appBarTheme.toolbarHeight ?? 50;
      _dragController.updatePositions([
        statusBarHeight + toolBarHeight - _floatingButtonOffset,
      ]);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top; // 状态栏高度
    double toolBarHeight = Theme.of(context).appBarTheme.toolbarHeight ?? 50;
    // 拖拽组件上拉到顶的极限距离
    _minimunPosition = statusBarHeight + (screenHeight < screenWidth ? 0 : toolBarHeight) - _floatingButtonOffset;
    _maximumPosition = screenHeight - _minRevealHeight;
    return Stack(
      children: [
        // 浏览区域
        Container(
          padding: const EdgeInsets.only(bottom: _minRevealHeight - _floatingButtonOffset - 20),
          alignment: Alignment.center,
          color: Colors.black,
          child: SingleChildScrollView(
            // padding: const EdgeInsets.only(bottom: 20),
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Consumer(builder: (_, ref, __) {
                double offset = ref.watch(_viewerOffsetProvider);
                return Transform.translate(
                  offset: Offset(0, -offset),
                  child: widget.viewerContent,
                );
              }),
            ),
          ),
        ),
        // 顶部阴影渐变区域
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: statusBarHeight,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0x80000000),
                Color(0x40000000),
                Color(0x00000000),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
        ),
        // appbar/toolbar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: widget.appBar,
        ),
        // 拖拽抽屉区域
        DragVerticalContainer(
          controller: _dragController,
          height:
              screenHeight - statusBarHeight - (screenHeight < screenWidth ? 0 : toolBarHeight) + _floatingButtonOffset,
          defaultPosition: screenHeight - _minRevealHeight,
          maximumPosition: _maximumPosition,
          dragStageOffset: 50,
          child: widget.bottomContentBuilder(_scrollController),
        ),
      ],
    );
  }
}
