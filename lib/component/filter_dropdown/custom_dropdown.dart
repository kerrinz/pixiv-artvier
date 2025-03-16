import 'package:flutter/material.dart';

typedef CustomDropDownListenerCallback = void Function();
typedef CustomDropDownChangeCallback = void Function(int index, String? value);
typedef CustomDropDownExpandCallback = void Function(int index, bool expanded);

class CustomDropDownController extends ChangeNotifier {
  late bool _isExpanded;
  bool get isExpanded => _isExpanded;
  CustomDropDownController({bool initialExpanded = false}) : _isExpanded = initialExpanded;

  void toggle() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  void open() {
    _isExpanded = true;
    notifyListeners();
  }

  void close() {
    _isExpanded = false;
    notifyListeners();
  }
}

class CustomDropDownOverlay extends StatefulWidget {
  const CustomDropDownOverlay({
    super.key,
    this.layerLink,
    this.padding,
    this.controller,
    this.onExpand,
    this.onChange,
    this.child,
  });

  final EdgeInsets? padding;

  final CustomDropDownController? controller;

  final CustomDropDownExpandCallback? onExpand;

  final CustomDropDownChangeCallback? onChange;

  final LayerLink? layerLink;

  final Widget? child;

  @override
  State<CustomDropDownOverlay> createState() => _CustomDropDownOverlayState();
}

class _CustomDropDownOverlayState extends State<CustomDropDownOverlay> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;
  late Animation<double> _animation;
  Color _maskColor = Colors.black45;
  late final LayerLink layerLink;

  late CustomDropDownController _customDropDownController;

  @override
  void initState() {
    super.initState();
    layerLink = widget.layerLink ?? LayerLink();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // 设置动画持续时间
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController); // 定义动画的值范围
    _animation.addStatusListener((status) {
      if (_animation.value == 0 && _animation.status == AnimationStatus.dismissed) {
        // 移除遮罩层
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    });
    _customDropDownController = widget.controller ?? CustomDropDownController();
    // 监听展开
    _customDropDownController.addListener(() {
      _customDropDownController.isExpanded ? expandMenu() : closeMenu();
    });
  }

  @override
  void deactivate() {
    closeMenu();
    super.deactivate();
  }

  @override
  void dispose() {
    closeMenuNoAnimation();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        closeMenu();
      },
      child: Builder(builder: ((context) {
        if (widget.layerLink != null) {
          return const SizedBox();
        } else {
          return CompositedTransformTarget(
            link: layerLink,
            child: const SizedBox(),
          );
        }
      })),
    );
  }

  void changeOverlay({bool reset = false}) {
    // TAG: 更新OverlayEntry数据需要清空之后重新构建
    if (reset && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    RenderBox? renderBox = (context).findRenderObject() as RenderBox;
    double left = 0;
    _overlayEntry = buildOverlay(
      link: layerLink,
      offset: Offset(-left, renderBox.size.height),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry buildOverlay({required link, required offset}) {
    return OverlayEntry(
      builder: (context) {
        return CompositedTransformFollower(
          link: link,
          offset: offset,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _animation,
                    child: GestureDetector(
                      onTap: () => _customDropDownController.close(),
                      child: Container(color: _maskColor),
                    ),
                  );
                },
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SizeTransition(
                      sizeFactor: _animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -1), // 从顶部开始
                          end: Offset.zero,
                        ).animate(_animation),
                        child: widget.child,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 展开菜单
  void expandMenu() {
    showOverlay();
    changeOverlay(reset: true);
  }

  /// 收缩菜单
  void closeMenu() {
    hideOverlay();
  }

  void closeMenuNoAnimation() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    _animationController.value = 0;
    _maskColor = Colors.transparent;
  }

  /// 显示遮罩
  void showOverlay() {
    _animationController.forward();
    _maskColor = Colors.black45;
  }

  /// 隐藏遮罩
  void hideOverlay() {
    _animationController.reverse();
    _maskColor = Colors.transparent;
  }
}
