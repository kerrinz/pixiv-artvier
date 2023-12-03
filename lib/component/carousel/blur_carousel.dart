import 'dart:ui';

import 'package:flutter/widgets.dart';

typedef IndicatorBuilder = Widget Function(int index);
typedef ItemBuilder = Widget Function(BuildContext context, int index);
typedef BackgroundBuilder = Widget Function(int index);

class BlurCarousel extends StatefulWidget {
  const BlurCarousel({
    super.key,
    required this.itemBuilder,
    required this.backgroundBuilder,
    this.indicatorBuilder,
    this.itemCount,
    this.loop = true,
  });

  final int? itemCount;

  final bool loop;

  // Carousel items
  final ItemBuilder itemBuilder;

  final BackgroundBuilder backgroundBuilder;

  final IndicatorBuilder? indicatorBuilder;

  final Duration fadeOutDuration = const Duration(milliseconds: 400);

  final Duration fadeInDuration = const Duration(milliseconds: 400);

  @override
  State<BlurCarousel> createState() => _BlurCarouselState();
}

class _BlurCarouselState extends State<BlurCarousel> with SingleTickerProviderStateMixin {
  /// 两个都用于 [background] 的索引
  /// 相当于双背景，根据页码切换决定哪个背景显示，哪个背景隐藏
  late final ValueNotifier<int> _frontIndexNotifier;
  late final ValueNotifier<int> _backindexNotifier;

  late final PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _backBackgroundAnimation;
  late Animation<double> _frontBackgroundAnimation;
  final Tween<double> _backgroundOddTween = Tween<double>(begin: 0, end: 1);
  final Tween<double> _backgroundEvenTween = Tween<double>(begin: 1, end: 1);

  int onesideTempSize = 2; // 幻灯片缓存数量（一侧）
  late int prevIndex; // 前一页（非线性）

  @override
  void initState() {
    prevIndex = 0;
    _frontIndexNotifier = ValueNotifier<int>(onesideTempSize);
    _backindexNotifier = ValueNotifier<int>(onesideTempSize);
    _pageController = PageController(
      viewportFraction: 0.86, // 缩放比例，用于预加载并显示前后一页部分内容
      initialPage: widget.loop ? onesideTempSize : 0,
    );
    _animationController = AnimationController(
      duration: const Duration(microseconds: 2000),
      value: 0.0,
      vsync: this,
    );
    _backBackgroundAnimation =
        _animationController.drive(CurveTween(curve: Curves.easeOut)).drive(_backgroundOddTween);
    _frontBackgroundAnimation =
        _animationController.drive(CurveTween(curve: Curves.easeOut)).drive(_backgroundEvenTween);
    _pageController.addListener(() {
      if (_pageController.page != null && _pageController.page! % 1 == 0) {
        // page为整数时，代表翻页刚好结束
        int currentIndex = _pageController.page!.toInt();
        if (widget.loop && widget.itemCount != null) {
          int ngIndex = positiveIndex2NegativeIndex(currentIndex, onesideTempSize);
          // 前后超出的跳转
          if (ngIndex < 0) {
            _pageController.jumpToPage(negativeIndex2PositiveIndex(widget.itemCount! + ngIndex, onesideTempSize));
          } else if (ngIndex > widget.itemCount!) {
            _pageController.jumpToPage(negativeIndex2PositiveIndex(ngIndex - widget.itemCount!, onesideTempSize));
          }
          // 背景图的动画
          if (_animationController.value == 1) {
            _backindexNotifier.value = prevIndex;
            _frontIndexNotifier.value = currentIndex;
            _animationController.animateTo(0.0, duration: widget.fadeOutDuration, curve: Curves.linear);
          } else {
            _frontIndexNotifier.value = prevIndex;
            _backindexNotifier.value = currentIndex;
            _animationController.animateTo(1.0, duration: widget.fadeOutDuration, curve: Curves.linear);
          }
        }
        prevIndex = currentIndex;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // font-background
        Positioned.fill(
          child: FadeTransition(
            opacity: _frontBackgroundAnimation,
            child: ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: ValueListenableBuilder<int>(
                  valueListenable: _frontIndexNotifier,
                  builder: (context, value, child) => _buildBackground(value),
                ),
              ),
            ),
          ),
        ),
        // back-background
        Positioned.fill(
          child: FadeTransition(
            opacity: _backBackgroundAnimation,
            child: ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: ValueListenableBuilder<int>(
                  valueListenable: _backindexNotifier,
                  builder: (context, value, child) => _buildBackground(value),
                ),
              ),
            ),
          ),
        ),
        PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            if (!widget.loop || widget.itemCount == null) {
              return widget.itemBuilder(context, index);
            }
            int negativeIndex = positiveIndex2NegativeIndex(index, onesideTempSize);
            // Loop
            if (negativeIndex < 0) {
              return widget.itemBuilder(context, widget.itemCount! + negativeIndex);
            } else if (negativeIndex >= widget.itemCount!) {
              return widget.itemBuilder(context, negativeIndex - widget.itemCount!);
            }
            return widget.itemBuilder(context, negativeIndex);
          },
          itemCount: widget.loop ? (widget.itemCount ?? 0) + onesideTempSize * 2 : widget.itemCount,
        ),
      ],
    );
  }

  Widget _buildBackground(int positiveIndex) {
    int backgroundIndex = positiveIndex;
    if (widget.loop && widget.itemCount != null) {
      // Loop
      int negativeIndex = positiveIndex2NegativeIndex(positiveIndex, onesideTempSize);
      backgroundIndex = negativeIndex;
      if (negativeIndex < 0) {
        backgroundIndex = widget.itemCount! + negativeIndex;
      } else if (negativeIndex >= widget.itemCount!) {
        backgroundIndex = negativeIndex - widget.itemCount!;
      }
    }
    return widget.backgroundBuilder(backgroundIndex);
  }

  /// 正的索引表转换成可负的索引表
  /// [index] 索引
  /// [onesideTempSize] 一侧的缓存数
  /// 例：0 1 2 3 4 5 6 (2~4为实际内容，其余为缓存) => -2 -1 0 1 2 3 4 (0~2为实际内容)
  int positiveIndex2NegativeIndex(int index, int onesideTempSize) {
    return index - onesideTempSize;
  }

  /// 可负的索引表转换成正的索引表
  int negativeIndex2PositiveIndex(int index, int onesideTempSize) {
    return index + onesideTempSize;
  }
}
