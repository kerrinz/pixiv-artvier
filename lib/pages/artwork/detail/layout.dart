import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/drag_view/drag_vertical_container.dart';
import 'package:artvier/component/drag_view/drag_vertical_panel.dart';

class ArtworkDetailPageLayout extends ConsumerStatefulWidget {
  const ArtworkDetailPageLayout({
    super.key,
    required this.appBar,
    required this.collectButton,
    required this.viewerContent,
    required this.slivers,
    this.dragController,
    this.isShapedScreen = false,
  });

  final Widget appBar;

  final Widget collectButton;

  final DragController? dragController;

  /// 图片的浏览区域
  final Widget viewerContent;

  /// Panel
  final List<Widget> slivers;

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

  late DragController _dragController;

  double _scrollOffset = 0;

  double _minimunPosition = 50;

  late double _maximumPosition;

  /// 收藏按钮的高度偏移量
  static const double _floatingButtonOffset = 20;

  /// 拖拽组件最小内容高度
  static const double _minRevealHeight = 180;

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  @override
  void dispose() {
    _scrollController.dispose();
    _dragController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _dragController = widget.dragController ?? DragController();
    _scrollController.addListener(() {
      _scrollOffset = _scrollController.offset;
    });
    _dragController.setDragListener((position, status) {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double statusBarHeight = MediaQuery.of(context).padding.top; // 状态栏高度
      double toolBarHeight = Theme.of(context).appBarTheme.toolbarHeight ?? 50;
      _dragController.updatePositions([
        statusBarHeight + toolBarHeight - _floatingButtonOffset,
        // MediaQuery.of(context).size.height / 2,
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
        DragVerticalPanel(
          controller: _dragController,
          height:
              screenHeight - statusBarHeight - (screenHeight < screenWidth ? 0 : toolBarHeight) + _floatingButtonOffset,
          defaultPosition: screenHeight - _minRevealHeight,
          maximumPosition: _maximumPosition,
          dragStageOffset: 50,
          body: Container(
            padding: const EdgeInsets.only(bottom: _minRevealHeight - _floatingButtonOffset - 20),
            alignment: Alignment.center,
            color: Colors.black,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: double.infinity,
                child: widget.viewerContent,
              ),
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                margin: const EdgeInsets.only(top: _floatingButtonOffset),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(50),
                        offset: const Offset(0, -_floatingButtonOffset),
                        blurRadius: 40,
                        spreadRadius: 5)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    slivers: widget.slivers,
                  ),
                ),
              ),
              // 收藏按钮
              Positioned(
                right: 20,
                child: widget.collectButton,
              ),
            ],
          ),
        ),
        // 状态栏阴影渐变
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
        // Appbar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: widget.appBar,
        ),
      ],
    );
  }
}
