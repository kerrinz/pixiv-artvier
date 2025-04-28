import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 250);

typedef CollapseCallback = void Function();
typedef ExpandCallback = void Function();

class ExpansionCustomController {
  /// 展开或收缩的动画进度
  ValueNotifier<double> get progress => _progress;
  late final ValueNotifier<double> _progress;

  /// 展开状态标识
  late bool _isExpanded;
  bool get isExpanded => _isExpanded;

  ExpansionCustomController({bool initialExpanded = false})
      : _isExpanded = initialExpanded,
        _progress = ValueNotifier<double>(initialExpanded ? 1 : 0);

  // 展开回调
  Iterable<ExpandCallback> get expandCallbackList => _expandCallbackList;
  final List<ExpandCallback> _expandCallbackList = <ExpandCallback>[];

  // 收缩回调
  Iterable<CollapseCallback> get collapseCallbackList => _collapseCallbackList;
  final List<CollapseCallback> _collapseCallbackList = <CollapseCallback>[];

  void attach(ExpandCallback expandCallback, CollapseCallback collapseCallback) {
    assert(!_expandCallbackList.contains(expandCallback));
    assert(!_collapseCallbackList.contains(collapseCallback));
    _expandCallbackList.add(expandCallback);
    _collapseCallbackList.add(collapseCallback);
  }

  void detach(ExpandCallback expandCallback, CollapseCallback collapseCallback) {
    assert(_expandCallbackList.contains(expandCallback));
    assert(_collapseCallbackList.contains(collapseCallback));
    _expandCallbackList.remove(expandCallback);
    _collapseCallbackList.remove(collapseCallback);
  }

  void setProgress(double progress) {
    _progress.value = progress;
  }

  void toggle() {
    _isExpanded ? collapse() : expand();
  }

  void expand() {
    if (!_isExpanded) {
      for (var expandCallback in _expandCallbackList) {
        expandCallback();
      }
      _isExpanded = true;
    }
  }

  void collapse() {
    if (_isExpanded) {
      for (var collapseCallback in _collapseCallbackList) {
        collapseCallback();
      }
      _isExpanded = false;
    }
  }
}

/// 折叠组件
class ExpansionCustom extends StatefulWidget {
  const ExpansionCustom({
    super.key,
    this.child,
    this.initialExpanded = false,
    required this.maxHeight,
    required this.minHeight,
    this.padding,
    this.controller,
  }) : assert(maxHeight > minHeight);

  final ExpansionCustomController? controller;
  final Widget? child;
  final bool initialExpanded;
  final double maxHeight;
  final double minHeight;
  final EdgeInsetsGeometry? padding;

  @override
  State<StatefulWidget> createState() => _ExpansionCustomState();
}

class _ExpansionCustomState extends State<ExpansionCustom> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeInOut);

  late ExpansionCustomController _expansionCustomController;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);

    _expansionCustomController = widget.controller ?? ExpansionCustomController();
    _expansionCustomController.attach(expandCallback, collapseCallback);
    if (widget.initialExpanded) {
      _controller.value = 1.0;
    }
    _controller.addListener(() {
      _expansionCustomController.setProgress(_controller.value);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void collapseCallback() {
    _controller.reverse();
  }

  void expandCallback() {
    _controller.forward();
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return SizedBox(
      height: widget.maxHeight * _heightFactor.value + widget.minHeight * (1 - _heightFactor.value),
      child: ClipRect(
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: _heightFactor.value,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = _expansionCustomController.isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : widget.child,
    );
  }
}
