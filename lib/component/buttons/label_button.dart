import 'package:flutter/material.dart';

/// 文字按钮，参考自 [CupertinoButton]
class LabelButton extends StatefulWidget {
  const LabelButton({
    super.key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.margin,
    this.padding = const EdgeInsets.all(4.0),
    this.background,
    this.pressedOpacity = 0.4,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.disabled = false,
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

  final bool disabled;

  bool get enabled => onPressed != null;

  @override
  State<StatefulWidget> createState() => _LabelButtonState();
}

class _LabelButtonState extends State<LabelButton> with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 120);
  static const Duration kFadeInDuration = Duration(milliseconds: 180);

  late AnimationController _animationController;

  bool _buttonHeldDown = false;

  late Animation<double> _opacityAnimation;

  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle(
      style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary) ??
          TextStyle(color: theme.colorScheme.primary),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.disabled ? null : widget.onPressed,
        child: Semantics(
          button: true,
          child: Container(
            margin: widget.margin,
            child: Align(
              alignment: widget.alignment,
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Container(
                  padding: widget.padding,
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius,
                    color: widget.background,
                  ),
                  child: widget.child,
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
  void didUpdateWidget(LabelButton old) {
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
    if (widget.disabled) return;
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (widget.disabled) return;
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (widget.disabled) return;
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (widget.disabled) return;
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
