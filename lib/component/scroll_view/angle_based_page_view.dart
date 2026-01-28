import 'dart:math';

import 'package:flutter/material.dart';

class AngleBasedPageView extends StatefulWidget {
  final double angleThreshold; // 角度阈值，默认30度

  final Widget Function(bool lockHorizontal) builder;

  const AngleBasedPageView({
    super.key,
    this.angleThreshold = 30,
    required this.builder,
  });

  @override
  createState() => _AngleBasedPageViewState();
}

class _AngleBasedPageViewState extends State<AngleBasedPageView> {
  Offset? _startOffset;
  double _lockAngle = 0;
  bool _lockHorizontal = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _startOffset = details.globalPosition;
        if (_lockHorizontal != false) {
          setState(() {
            _lockHorizontal = false;
          });
        }
        _lockAngle = widget.angleThreshold;
      },
      onPanUpdate: (details) {
        if (_startOffset == null) return;

        final offset = details.globalPosition - _startOffset!;
        final angle = _calculateAngle(offset.dx, offset.dy);

        // 如果滑动角度小于阈值，则认为是水平滑动
        // 如果角度大于阈值，则锁定水平滑动
        if (angle.abs() > _lockAngle && _lockHorizontal != true) {
          setState(() {
            _lockHorizontal = true;
          });
        }
      },
      onPanEnd: (_) {
        _startOffset = null;
        if (_lockHorizontal != false) {
          setState(() {
            _lockHorizontal = false;
          });
        }
      },
      child: widget.builder(_lockHorizontal),
    );
  }

  double _calculateAngle(double dx, double dy) {
    if (dx == 0) return 90;
    return atan(dy.abs() / dx.abs()) * (180 / pi);
  }
}
