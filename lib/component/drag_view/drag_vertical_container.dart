import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/component/bottom_sheet/slide_bar.dart';

/// 拖拽事件的动作状态
enum DragStatus {
  /// 拖动开始
  start,

  /// 拖动中
  update,

  /// 拖动结束
  end,
}

typedef DragCallback = void Function(double position);

typedef DragListener = void Function(double position, DragStatus status);

/// [DragVerticalContainer]的拖拽控制器
/// - 注意：Position/位置，均指组件的顶点相对于父组件顶部的距离
class DragController extends ChangeNotifier {
  /// 回调函数，通过它可以实现代码控制拖拽操作，而无需手势
  DragCallback? _dragToCallback;

  /// Drag拖拽事件发生时会执行的钩子函数，类似于.addListener()，
  DragListener? dragListener;

  /// 组件拖拽时可供停留的位置
  ///
  /// - **不要包含**最大位置，即[DragVerticalContainer.maximumPosition]
  /// - 保持**从小到大**的顺序定义，并且不要出现重复值
  Iterable<double> get extendPositions => _positions;
  final List<double> _positions = <double>[];

  /// 是否支持中途停留，即多段式拖拽
  /// - 如果为false，则[stopoverPositions]将只有最后一个元素（即最小位置）生效
  bool canStopover = true;

  /// 是否允许拖拽（在特定Scroll事件的情况下会禁止拖拽）
  bool canDrag = true;

  void setDragToCallback(DragCallback callback) {
    _dragToCallback = callback;
  }

  void setDragListener(DragListener listener) {
    dragListener = listener;
  }

  /// 类似于[ScrollController.animateTo]
  void dragTo(double position) {
    if (_dragToCallback != null) {
      _dragToCallback!(position);
    }
  }

  /// 更新可供中途停留的位置列表
  void updatePositions(List<double> positions) {
    assert(positions.isSorted(canContainsDuplicates: false)); // 从大到小、不可重复
    _positions.clear();
    _positions.addAll(positions);
  }

  /// 设置是否支持中途停留
  void setCanStopover(bool canStopover) {
    this.canStopover = canStopover;
  }

  /// 设置是否可以拖拽
  void setCanDrag(bool canDrag) {
    this.canDrag = canDrag;
  }
}

/// 拓展List<double>
extension ExtensionList on List<double> {
  /// 是否为有序数组，[smallToLarge]是否从小到大，[canContainsDuplicates]是否可以包含重复项
  bool isSorted({bool smallToLarge = true, bool canContainsDuplicates = true}) {
    // 非多项，那就是有序
    if (length <= 1) return true;
    if (smallToLarge) {
      for (int i = 1; i < length; i++) {
        // 只要有一对是大和小，就是非有序
        if (elementAt(i - 1) > elementAt(i)) return false;
        // 包含重复项
        if (!canContainsDuplicates && elementAt(i - 1) == elementAt(i)) return false;
      }
    } else {
      for (int i = 1; i < length; i++) {
        // 只要有一对是小和大，就是非有序
        if (elementAt(i - 1) < elementAt(i)) return false;
        // 包含重复项
        if (!canContainsDuplicates && elementAt(i - 1) == elementAt(i)) return false;
      }
    }
    return true;
  }
}

/// 垂直的拖动组件，可以悬停于多个指定相对高度位置。
/// 比较像[BottomSheet]但附加了拖动悬停以及对于内含滚动视图的更好支持。
class DragVerticalContainer extends StatefulWidget {
  /// 容器宽度，一般不超过屏幕分辨率宽度
  final double width;

  /// 容器高度，一般不超过屏幕分辨率高度
  final double height;

  /// 初次加载时的默认位置（相对于父组件的顶部）
  final double defaultPosition;

  /// 拖拽到最大位置，此位置将无法再往下拖动（组件下移）
  final double maximumPosition;

  /// 抵达另一个阶段位置所需要的拖动偏移量
  ///
  /// 例如，当手势拖动超过指定距离时，组件的位置将变为可供停留的另一个位置
  final double dragStageOffset;

  final DragController? controller;

  /// 是否可以自由拖拽停留，如果开启，则不会在松手时强制寻找最近的点
  // final bool canCustomizedStopover;

  const DragVerticalContainer({
    Key? key,
    this.child,
    this.controller,
    this.width = double.infinity,
    // this.canCustomizedStopover = false,
    required this.height,
    required this.defaultPosition,
    required this.dragStageOffset,
    required this.maximumPosition,
  })  : assert(defaultPosition <= maximumPosition),
        super(key: key);

  final Widget? child;

  Widget panelBuilder(BuildContext context, double positionY,
      GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer> recognizer) {
    return Transform.translate(
      offset: Offset(0.0, positionY),
      child: RawGestureDetector(
        gestures: {MyVerticalDragGestureRecognizer: recognizer},
        child: SizedBox(
          height: height,
          child: child,
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => DragContainerState();
}

class DragContainerState extends State<DragVerticalContainer> with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 500);

  static const Duration kFadeInDuration = Duration(milliseconds: 500);

  /// 默认位置
  double get defaultY => widget.defaultPosition;

  /// 最小位置（无法再上拉）
  double get min => dragController.extendPositions.firstWhere((element) => true, orElse: () => max);

  double get max => widget.maximumPosition;

  /// 可供中途停留的位置
  Iterable<double> get stopoverPositions => dragController.extendPositions;

  /// 本组件目前停留的的位置，作用于视图
  late double positionY;

  /// 缓存上一次的位置
  late double lastPositionY;

  /// 动画控制相关
  late final AnimationController animationController;
  late Animation<double> animation;
  late final CurvedAnimation curve;
  final Tween<double> tween = Tween<double>();

  /// 拖动的控制器
  late DragController dragController;

  bool get canDrag => dragController.canDrag;

  @override
  void initState() {
    // 初始化默认位置
    positionY = defaultY;
    lastPositionY = defaultY;

    // 初始化动画相关配置
    animationController =
        AnimationController(vsync: this, duration: kFadeInDuration, reverseDuration: kFadeOutDuration);
    // 动画执行期间也要通知监听器
    animationController.addListener(() {
      if (dragController.dragListener != null) {
        dragController.dragListener!(positionY, DragStatus.update);
      }
    });
    curve = CurvedAnimation(parent: animationController, curve: Curves.fastLinearToSlowEaseIn);
    animation = tween.animate(curve)
      ..addListener(() {
        // 在动画变化时更新UI
        positionY = animation.value;
        setState(() {});
      });

    // 控制器初始化
    dragController = (widget.controller ?? DragController())
      ..setDragToCallback((position) {
        // 在回调函数被调用时执行拖拽动画
        positionY = position;
        tween.begin = lastPositionY;
        tween.end = position;
        animationController.forward().whenComplete(() {
          tween.begin = position;
          animationController.reset();
        });
        lastPositionY = position;
      });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DragVerticalContainer oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 重新归位，以避免分辨率变化导致错位
      positionY = defaultY;
      lastPositionY = defaultY;
      setState(() {});
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollNotification>(
      onNotification: ((notification) {
        // 滚动抵达顶部边界，允许触发拖拽事件
        if (notification.metrics.extentBefore == 0) {
          dragController.setCanDrag(true);
        }
        return false;
      }),
      child: NotificationListener<ScrollEndNotification>(
        onNotification: ((notification) {
          dragController.setCanDrag(true);
          return false;
        }),
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: ((notification) {
            // 页面往顶部方向移动，禁止本组件发生拖拽
            if ((notification.dragDetails?.delta.dy ?? 0.0) > 0.0) {
              dragController.setCanDrag(false);
            }
            return false;
          }),
          child: NotificationListener<ScrollStartNotification>(
            onNotification: ((notification) {
              // 非已滚动到顶，不让滚动事件引发拖拽事件
              if (notification.metrics.extentBefore != 0) {
                dragController.setCanDrag(false);
              }
              return false;
            }),
            child: widget.panelBuilder(context, positionY, recognizer()),
          ),
        ),
      ),
    );
  }

  GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer> recognizer() {
    return GestureRecognizerFactoryWithHandlers(
      () => MyVerticalDragGestureRecognizer(),
      (instance) => instance
        ..onStart = _onStart
        ..onUpdate = _onUpdate
        ..onEnd = _onEnd,
    );
  }

  /// 接触屏幕
  void _onStart(DragStartDetails details) {
    if (dragController.dragListener != null) {
      dragController.dragListener!(positionY, DragStatus.start);
    }
  }

  /// 拖动过程中
  void _onUpdate(DragUpdateDetails details) {
    // 滚动已达顶部并且Drag位置处在最大化时
    if (!canDrag) return;
    if (dragController.dragListener != null) {
      dragController.dragListener!(positionY, DragStatus.update);
    }
    // 不能再往下拖动了
    if (positionY == max && details.delta.dy >= 0) {
      return;
    }
    // 不能再往上拖动了
    if (positionY == min && details.delta.dy <= 0) {
      return;
    }
    if (positionY >= min && positionY <= max) {
      positionY += details.delta.dy;
      if (positionY < min) positionY = min;
      if (positionY > max) positionY = max;
      setState(() {});
    }
  }

  /// 离开屏幕
  void _onEnd(DragEndDetails details) {
    if (dragController.dragListener != null) {
      dragController.dragListener!(positionY, DragStatus.end);
    }
    double offsetY = positionY - lastPositionY; // 本次拖动产生的的最终视觉偏移量（也就是拖动的距离）
    if (offsetY.abs() > widget.dragStageOffset) {
      // 拖动幅度较大，变更位置
      double toY; // 准备移动到该位置
      if (offsetY < 0) {
        // 往上拖动
        // 查找距离最近的前一个位置，不允许中途停留则上拉到顶
        toY = dragController.canStopover
            ? [min, ...stopoverPositions].lastWhere((element) => element < positionY, orElse: () => min)
            : min;
      } else {
        // 往下拖动
        // 查找距离最近的后一个位置，不允许中途停留则下拉到底
        toY = dragController.canStopover
            ? [min, ...stopoverPositions].firstWhere((element) => element > positionY, orElse: () => max)
            : max;
      }
      tween.begin = positionY;
      tween.end = toY;
      animationController.forward().whenComplete(() {
        tween.begin = toY;
        animationController.reset();
      });
      lastPositionY = toY; // 更新上一个位置的缓存
    } else {
      // 拖动幅度太小，回到上一个位置
      tween.begin = positionY;
      tween.end = lastPositionY;
      animationController.forward().whenComplete(() {
        tween.begin = lastPositionY;
        animationController.reset();
      });
    }
  }

  @override
  void dispose() {
    dragController.dispose();
    super.dispose();
  }
}

class MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  MyVerticalDragGestureRecognizer({Object? debugOwner}) : super(debugOwner: debugOwner);

  @override
  void rejectGesture(int pointer) {
    // 强行取得竞技胜利
    super.acceptGesture(pointer);
  }
}

/// 去除Android设备滚动到边界后的动画效果
class CusBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    if (Platform.isAndroid || Platform.isFuchsia) return child;
    return super.buildOverscrollIndicator(context, child, details);
  }
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextPageState2();
}

class _TextPageState2 extends State<TestPage> {
  DragController dragController = DragController();

  ScrollController? scrollController;

  /// 标记是否初始化Controller
  bool flagControllerInit = false;

  // Drag拖拽组件阶段1增量的上下文
  late BuildContext _increase1Context;

  static const double minRevealHeight = 160;

  double scrollOffset = 0;

  double minimunPosition = minRevealHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool isHorizontal = MediaQuery.of(context).size.height < MediaQuery.of(context).size.width; // 是否横屏模式
      dragController.updatePositions(
        [
          if (!isHorizontal && _increase1Context.size != null)
            MediaQuery.of(context).size.height - minRevealHeight - _increase1Context.size!.height,
        ],
      );
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    minimunPosition = MediaQuery.of(context).padding.top + (isHorizontal ? 0 : 50);
    if (!flagControllerInit) {
      scrollController = PrimaryScrollController.of(context) ?? ScrollController();
      scrollController!.addListener(() {
        scrollOffset = scrollController!.offset;
        // 滚动到顶才允许拖拽
        if (scrollController!.offset > 0) {
          dragController.setCanStopover(false);
        } else {
          dragController.setCanStopover(true);
        }
      });
      dragController.setDragListener((position, status) {
        if (position != minimunPosition) {
          scrollController!.jumpTo(scrollOffset);
        }
      });
      flagControllerInit = true;
    }
    return Scaffold(
      body: Stack(
        children: [
          InkWell(
            onTap: () {
              dragController.dragTo(400);
            },
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Text("234789234897"),
            ),
          ),
          DragVerticalContainer(
            controller: dragController,
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - (isHorizontal ? 0 : 50),
            defaultPosition: MediaQuery.of(context).size.height - minRevealHeight,
            maximumPosition: MediaQuery.of(context).size.height - minRevealHeight,
            dragStageOffset: 50,
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.indigoAccent,
                      child: const BottomSheetSlideBar(), // 占位20高度
                    ),
                    Container(
                      width: double.infinity,
                      height: minRevealHeight - 20,
                      color: Colors.blueAccent,
                      child: const Text("Header"),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.orangeAccent,
                    child: PrimaryScrollController(
                      controller: scrollController!,
                      child: CustomScrollView(
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Builder(builder: (context1) {
                              _increase1Context = context1;
                              return Container(
                                width: double.infinity,
                                color: Colors.lightGreen,
                                child: ListView.builder(
                                  // controller: scrollController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(index.toString()),
                                    );
                                  }),
                                  itemCount: 10,
                                ),
                              );
                            }),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(index.toString()),
                              );
                            }, childCount: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
