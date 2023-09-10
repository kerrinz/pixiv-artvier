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

  final Duration fadeOutDuration = const Duration(milliseconds: 200);

  final Duration fadeInDuration = const Duration(milliseconds: 200);

  @override
  State<BlurCarousel> createState() => _BlurCarouselState();
}

class _BlurCarouselState extends State<BlurCarousel> with SingleTickerProviderStateMixin {
  final _currentIndexNotifier = ValueNotifier<int>(0);
  late final PageController _pageController;

  late AnimationController _animationController;
  late Animation<double> _currentOpacityAnimation;
  late Animation<double> _previousopacityAnimation;
  final Tween<double> _currentOpacityTween = Tween<double>(begin: 0, end: 1);
  final Tween<double> _previousOpacityTween = Tween<double>(begin: 1, end: 0);

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: 0.8, // 缩放比例，用于预加载并显示前后一页部分内容
      initialPage: widget.loop ? 1 : 0,
    );
    _animationController = AnimationController(
      duration: const Duration(microseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _currentOpacityAnimation =
        _animationController.drive(CurveTween(curve: Curves.decelerate)).drive(_currentOpacityTween);
    _previousopacityAnimation =
        _animationController.drive(CurveTween(curve: Curves.decelerate)).drive(_previousOpacityTween);
    super.initState();
  }

  // void _animateTo() {
  //   _animationController.animateTo(1.0, duration: widget.fadeOutDuration, curve: Curves.easeInOutCubicEmphasized);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // previous
        Positioned.fill(
          child: FadeTransition(
            opacity: _previousopacityAnimation,
            child: ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentIndexNotifier,
                  builder: (context, value, child) {
                    return widget.backgroundBuilder(value);
                  },
                ),
              ),
            ),
          ),
        ),
        // current
        Positioned.fill(
          child: FadeTransition(
            opacity: _currentOpacityAnimation,
            child: ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentIndexNotifier,
                  builder: (context, value, child) {
                    return widget.backgroundBuilder(value);
                  },
                ),
              ),
            ),
          ),
        ),
        PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            if (!widget.loop) {
              return widget.itemBuilder(context, index);
            }
            // Loop
            if (index == 0) {
              return widget.itemBuilder(context, (widget.itemCount ?? 1) - 1);
            }
            if (index == (widget.itemCount ?? 0) + 1) {
              return widget.itemBuilder(context, 0);
            }
            return widget.itemBuilder(context, index - 1);
          },
          itemCount: widget.loop ? (widget.itemCount ?? 0) + 2 : widget.itemCount,
          onPageChanged: (newIndex) {
            if (!widget.loop) {
              // Save the index
              _currentIndexNotifier.value = newIndex;
            } else if (widget.loop) {
              if (newIndex == 0) {
                _pageController.jumpToPage(widget.itemCount ?? 1);
                _currentIndexNotifier.value = (widget.itemCount ?? 1) - 1;
              } else if (newIndex == (widget.itemCount ?? 0) + 1) {
                _pageController.jumpToPage(1);
                _currentIndexNotifier.value = 1;
              } else {
                _currentIndexNotifier.value = newIndex - 1;
              }
            }
            // _animateToNext();
            // Play animation
          },
        ),
      ],
    );
  }
}
