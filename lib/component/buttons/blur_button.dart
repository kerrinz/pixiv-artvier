import 'package:flutter/material.dart';

///
/// 背景高斯模糊按钮，参考了 [CupertinoButton]
/// [opacityColor] : 背景色，需要带Alpha或Opacity才能有半透明效果
/// [pressedOpacity] : 按下时的背景透明度，最终背景透明度 = [opacityColor] * [pressedOpacity]
///

class BlurButton extends StatefulWidget {
  const BlurButton({
    super.key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.margin,
    this.padding = const EdgeInsets.all(4.0),
    this.background,
    this.pressedOpacity = 0.66,
    this.alignment = Alignment.center,
    this.width,
    this.height,
  });

  final Alignment alignment;

  final BorderRadius? borderRadius;

  final Widget child;

  /// This margin area can still trigger the press event.
  final EdgeInsets? margin;

  final EdgeInsets? padding;

  // set null to disable button.
  final VoidCallback? onPressed;

  final Color? background;

  final double pressedOpacity;

  final double? width;

  final double? height;

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
            child: FadeTransition(
              //  ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              opacity: _opacityAnimation,
              child: Container(
                padding: widget.padding,
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  color: widget.background ?? const Color(0xff000000).withOpacity(0.33),
                ),
                child: widget.child,
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

class AppbarBlurIconButton extends StatelessWidget {
  const AppbarBlurIconButton({super.key, required this.onPressed, required this.icon, this.margin, this.padding});

  final Function() onPressed;

  final Widget icon;

  /// This margin area can still trigger the press event.
  final EdgeInsets? margin;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return BlurButton(
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      padding: EdgeInsets.zero,
      background: const Color.fromARGB(100, 0, 0, 0),
      margin: margin,
      width: 32,
      height: 32,
      onPressed: onPressed,
      child: icon,
    );
  }
}
