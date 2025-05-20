import 'package:flutter/material.dart';

/// 分段滑块
/// 外嵌套 [SliderTheme] 自定义样式
class DivisionSlider extends StatefulWidget {
  const DivisionSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.divisions,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.mouseCursor,
    this.semanticFormatterCallback,
    this.focusNode,
    this.autofocus = false,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final MouseCursor? mouseCursor;
  final SemanticFormatterCallback? semanticFormatterCallback;
  final FocusNode? focusNode;
  final bool autofocus;
  final List<double> divisions;

  @override
  State<DivisionSlider> createState() => _DivisionsSliderState();
}

class _DivisionsSliderState extends State<DivisionSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Slider(
        value: _value,
        onChanged: (value) {
          updateValue(value);
        },
        onChangeStart: widget.onChangeStart,
        onChangeEnd: widget.onChangeEnd,
        min: widget.min,
        max: widget.max,
        label: widget.label,
        activeColor: widget.activeColor,
        inactiveColor: widget.inactiveColor,
        thumbColor: widget.thumbColor,
        mouseCursor: widget.mouseCursor,
        semanticFormatterCallback: widget.semanticFormatterCallback,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
      ),
    );
  }

  void updateValue(double value) {
    var minValue = double.infinity;
    var result = 0.0;
    for (var element in widget.divisions) {
      double min = (value - element).abs();
      if (min < minValue) {
        result = element;
        minValue = min;
      }
    }
    if (_value == result) {
      return;
    }
    setState(() {
      _value = result;
      if (widget.onChanged != null) {
        widget.onChanged?.call(_value);
      }
    });
  }
}
