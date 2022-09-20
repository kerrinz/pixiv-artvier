import 'dart:ui';
import 'package:flutter/material.dart';

///
/// 背景高斯模糊按钮，参考了 [CupertinoButton]
/// [opacityColor] : 背景色，需要带Alpha或Opacity才能有半透明效果
/// [pressedOpacity] : 按下时的背景透明度，最终背景透明度 = [opacityColor] * [pressedOpacity]
///
class BlurButton extends StatefulWidget {
  const BlurButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.margin,
    this.padding = const EdgeInsets.all(4.0),
    this.opacityColor,
    this.pressedOpacity = 0.66,
    this.alignment = Alignment.center,
  }) : super(key: key);

  const BlurButton.leadingBack({
    Key? key,
    required this.onPressed,
    this.child = const Icon(Icons.arrow_back_ios_rounded, size: 16),
    this.borderRadius = const BorderRadius.all(Radius.circular(20.0)),
    this.margin,
    this.padding = const EdgeInsets.all(8.0),
    this.opacityColor,
    this.pressedOpacity = 0.66,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final Alignment alignment;

  final BorderRadius? borderRadius;

  final Widget child;

  final EdgeInsets? margin;

  final VoidCallback? onPressed; // set null to disable button.

  final Color? opacityColor;

  final EdgeInsets? padding;

  final double pressedOpacity;

  bool get enabled => onPressed != null;

  @override
  State<StatefulWidget> createState() => _BlurButtonState();
}

class _BlurButtonState extends State<BlurButton> with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 120);

  static const Duration kFadeInDuration = Duration(milliseconds: 180);

  late AnimationController _animationController;

  bool _buttonHeldDown = false;

  late Animation<double> _opacityAnimation;

  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: Semantics(
        button: true,
        child: Container(
          margin: widget.margin,
          child: Align(
            alignment: widget.alignment,
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: Container(
                    padding: widget.padding,
                    color: widget.opacityColor ?? const Color(0xff000000).withOpacity(0.25),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(microseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController.drive(CurveTween(curve: Curves.decelerate)).drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(BlurButton old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setTween() {
    _opacityTween.end = widget.pressedOpacity;
  }

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) return;
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController.animateTo(1.0, duration: kFadeOutDuration, curve: Curves.easeInOutCubicEmphasized)
        : _animationController.animateTo(0.0, duration: kFadeInDuration, curve: Curves.easeOutCubic);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }
}
