import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:artvier/component/layout/size_reporting_widget.dart';
import 'package:artvier/component/scroll_view/extend_page_view.dart';

class ExtendTabBarView extends StatefulWidget {
  /// Creates a page view with one child per tab.
  ///
  /// The length of [children] must be the same as the [controller]'s length.
  const ExtendTabBarView({
    super.key,
    required this.children,
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
    this.scrollDirection = Axis.horizontal,
    this.autoHeight = false,
  });

  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController? controller;

  /// One widget per tab.
  ///
  /// Its length must match the length of the [TabBar.tabs]
  /// list, as well as the [controller]'s [TabController.length].
  final List<Widget> children;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.pageview.viewportFraction}
  final double viewportFraction;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  ///The axis along which the page view scrolls.
  //
  // Defaults to Axis.horizontal.
  final Axis scrollDirection;

  final bool autoHeight;

  @override
  State<ExtendTabBarView> createState() => _TabBarViewState();
}

class _TabBarViewState extends State<ExtendTabBarView> {
  TabController? _controller;
  late PageController _pageController;
  late List<Widget> _children;
  late List<Widget> _childrenWithKey;
  int? _currentIndex;
  late int _previousIndex;
  int _warpUnderwayCount = 0;
  bool _debugHasScheduledValidChildrenCountCheck = false;
  // late List<double> _heights;
  late List<double> _sizes;
  // `true` if TabController change the page index.
  // `false` if gestures change the page index.
  bool _isTabAction = false;

  double get _currentSize => _sizes[_currentIndex!];
  double get _previousSize => _sizes[_previousIndex];
  // double get _currentHeight => _heights[_currentIndex ?? 0];
  bool get _isHorizontalScroll => widget.scrollDirection == Axis.horizontal;

  // If the TabBarView is rebuilt with a new tab controller, the caller should
  // dispose the old one. In that case the old controller's animation will be
  // null and should not be accessed.
  bool get _controllerIsValid => _controller?.animation != null;

  void _updateTabController() {
    final TabController newController = widget.controller ?? DefaultTabController.of(context);
    if (newController == _controller) {
      return;
    }

    if (_controllerIsValid) {
      _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
    }
    _controller = newController;
    if (_controller != null) {
      _controller!.animation!.addListener(_handleTabControllerAnimationTick);
    }
  }

  @override
  void initState() {
    // _heights = widget.children.map((e) => 0.0).toList();
    _sizes = widget.children.map((e) => 0.0).toList();
    super.initState();
    _updateChildren();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
    _currentIndex = _controller!.index;
    _previousIndex = _currentIndex!;
    _pageController = PageController(
      initialPage: _currentIndex!,
      viewportFraction: widget.viewportFraction,
    )..addListener(_pageScrollListenner);

    _controller!.addListener(() {
      // Notify size if not auto height.
      if (!widget.autoHeight && _controller!.index == _controller!.animation!.value) {
        PageViewSizeChangedNotification(
                _sizes, _controller!.previousIndex, _controller!.index, NotificationStatus.tabBarChanged)
            .dispatch(context);
      }
    });
  }

  @override
  void didUpdateWidget(ExtendTabBarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
      _currentIndex = _controller!.index;
      _warpUnderwayCount += 1;
      _pageController.jumpToPage(_currentIndex!);
      _warpUnderwayCount -= 1;
    }
    if (widget.children != oldWidget.children && _warpUnderwayCount == 0) {
      _updateChildren();
    }
  }

  @override
  void dispose() {
    if (_controllerIsValid) {
      _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
    }
    _controller = null;
    // We don't own the _controller Animation, so it's not disposed here.
    super.dispose();
  }

  void _updateChildren() {
    _children = widget.autoHeight ? _sizeReportingWithUpdateChildren() : _sizeReportingChildren();
    _childrenWithKey = KeyedSubtree.ensureUniqueKeysForList(_children);
  }

  void _handleTabControllerAnimationTick() {
    if (_warpUnderwayCount > 0 || !_controller!.indexIsChanging) {
      return;
    } // This widget is driving the controller's animation.

    if (_controller!.index != _currentIndex) {
      _currentIndex = _controller!.index;
      _warpToCurrentIndex().whenComplete(() {
        _isTabAction = false;
      });
    }
  }

  Future<void> _warpToCurrentIndex() async {
    if (!mounted) {
      return Future<void>.value();
    }

    if (_pageController.page == _currentIndex!.toDouble()) {
      return Future<void>.value();
    }

    _isTabAction = true;
    // Notify size if auto height.
    if (widget.autoHeight) {
      final newPage = _pageController.page!.round();
      PageViewSizeChangedNotification(_sizes, newPage, _currentIndex!, NotificationStatus.tabBarChanged)
          .dispatch(context);
    }

    final Duration duration = _controller!.animationDuration;
    final int previousIndex = _controller!.previousIndex;

    if ((_currentIndex! - previousIndex).abs() == 1) {
      if (duration == Duration.zero) {
        _pageController.jumpToPage(_currentIndex!);
        return Future<void>.value();
      }
      _warpUnderwayCount += 1;
      await _pageController.animateToPage(_currentIndex!, duration: duration, curve: Curves.ease);
      _warpUnderwayCount -= 1;
      return Future<void>.value();
    }

    assert((_currentIndex! - previousIndex).abs() > 1);
    final int initialPage = _currentIndex! > previousIndex ? _currentIndex! - 1 : _currentIndex! + 1;
    final List<Widget> originalChildren = _childrenWithKey;
    setState(() {
      _warpUnderwayCount += 1;

      _childrenWithKey = List<Widget>.of(_childrenWithKey, growable: false);
      final Widget temp = _childrenWithKey[initialPage];
      _childrenWithKey[initialPage] = _childrenWithKey[previousIndex];
      _childrenWithKey[previousIndex] = temp;
    });
    _pageController.jumpToPage(initialPage);

    if (duration == Duration.zero) {
      _pageController.jumpToPage(_currentIndex!);
      return Future<void>.value();
    }

    await _pageController.animateToPage(_currentIndex!, duration: duration, curve: Curves.ease);
    if (!mounted) {
      return Future<void>.value();
    }
    setState(() {
      _warpUnderwayCount -= 1;
      if (widget.children != _children) {
        _updateChildren();
      } else {
        _childrenWithKey = originalChildren;
      }
    });
  }

  // Called when the PageView scrolls
  bool _handleScrollNotification(ScrollNotification notification) {
    if (_warpUnderwayCount > 0) {
      return false;
    }

    if (notification.depth != 0) {
      return false;
    }

    _warpUnderwayCount += 1;
    if (notification is ScrollUpdateNotification && !_controller!.indexIsChanging) {
      if ((_pageController.page! - _controller!.index).abs() > 1.0) {
        _controller!.index = _pageController.page!.round();
        _currentIndex = _controller!.index;
      }
      _controller!.offset = clampDouble(_pageController.page! - _controller!.index, -1.0, 1.0);
    } else if (notification is ScrollEndNotification) {
      _controller!.index = _pageController.page!.round();
      _currentIndex = _controller!.index;
      if (!_controller!.indexIsChanging) {
        _controller!.offset = clampDouble(_pageController.page! - _controller!.index, -1.0, 1.0);
      }
    }
    _warpUnderwayCount -= 1;

    return false;
  }

  bool _debugScheduleCheckHasValidChildrenCount() {
    if (_debugHasScheduledValidChildrenCountCheck) {
      return true;
    }
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      _debugHasScheduledValidChildrenCountCheck = false;
      if (!mounted) {
        return;
      }
      assert(() {
        if (_controller!.length != widget.children.length) {
          throw FlutterError(
            "Controller's length property (${_controller!.length}) does not match the "
            "number of children (${widget.children.length}) present in TabBarView's children property.",
          );
        }
        return true;
      }());
    });
    _debugHasScheduledValidChildrenCountCheck = true;
    return true;
  }

  void _pageScrollListenner() {
    final newPage = _pageController.page!.round();
    if (!_isTabAction && _currentIndex != newPage) {
      PageViewSizeChangedNotification(_sizes, _currentIndex!, newPage, NotificationStatus.gestureDragging)
          .dispatch(context);
      // According to the progress of dragging, switch PageView to the previous or next page
      setState(() {
        _previousIndex = _currentIndex!;
        _currentIndex = newPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugScheduleCheckHasValidChildrenCount());

    if (!widget.autoHeight) {
      return NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: PageView(
          dragStartBehavior: widget.dragStartBehavior,
          clipBehavior: widget.clipBehavior,
          controller: _pageController,
          physics: widget.physics == null
              ? const PageScrollPhysics().applyTo(const ClampingScrollPhysics())
              : const PageScrollPhysics().applyTo(widget.physics),
          children: _childrenWithKey,
        ),
      );
    }

    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _previousSize, end: _currentSize),
      builder: ((context, value, child) => SizedBox(
            height: _isHorizontalScroll ? value : null,
            width: !_isHorizontalScroll ? value : null,
            child: child,
          )),
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: PageView(
          dragStartBehavior: widget.dragStartBehavior,
          clipBehavior: widget.clipBehavior,
          controller: _pageController,
          physics: widget.physics == null
              ? const PageScrollPhysics().applyTo(const ClampingScrollPhysics())
              : const PageScrollPhysics().applyTo(widget.physics),
          children: _childrenWithKey,
        ),
      ),
    );
  }

  List<Widget> _sizeReportingChildren() => widget.children
      .asMap()
      .map(
        (index, child) => MapEntry(
          index,
          SizeReportingWidget(
            onSizeChange: (size) {
              _sizes[index] = _isHorizontalScroll ? size.height : size.width;
              PageViewSizeChangedNotification(
                      _sizes, _controller!.previousIndex, _controller!.index, NotificationStatus.sizeChanged)
                  .dispatch(context);
            },
            child: child,
          ),
        ),
      )
      .values
      .toList();

  List<Widget> _sizeReportingWithUpdateChildren() => widget.children
      .asMap()
      .map(
        (index, child) => MapEntry(
          index,
          OverflowPage(
            onSizeChange: (size) => setState(() => _sizes[index] = _isHorizontalScroll ? size.height : size.width),
            alignment: Alignment.topCenter,
            scrollDirection: widget.scrollDirection,
            child: child,
          ),
        ),
      )
      .values
      .toList();
}

/// Notify if width or height changed of PageView.
///
/// Work with gestures.
class PageViewSizeChangedNotification extends Notification {
  /// The width or height in the opposite direction to [ExpandablePageView.scrollDirection]
  final List<double> sizes;

  final int currentPage;

  final int newPage;

  final NotificationStatus status;

  const PageViewSizeChangedNotification(this.sizes, this.currentPage, this.newPage, this.status);
}

enum NotificationStatus {
  sizeChanged,
  gestureDragging,
  tabBarChanged,
}
