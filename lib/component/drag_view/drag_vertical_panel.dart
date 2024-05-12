import 'package:flutter/material.dart';
import 'package:artvier/component/drag_view/drag_vertical_container.dart';

class DragVerticalPanel extends DragVerticalContainer {
  const DragVerticalPanel({
    super.key,
    super.controller,
    super.width = double.infinity,
    this.bodyFollowDragFactor = 1.8,
    required this.body,
    required super.child,
    required super.height,
    required super.defaultPosition,
    required super.dragStageOffset,
    required super.maximumPosition,
  }) : assert(defaultPosition <= maximumPosition);

  /// Behind the panel widget
  final Widget body;

  /// [body] 的拖拽阻力因子，当值为1时，[body] 完全跟随 [panel] 拖动；当>1且越大时，越不跟随拖动
  final double bodyFollowDragFactor;

  @override
  Widget parentBuilder(BuildContext context, double positionY, DragController dragController,
      GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer> recognizer) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset(0.0, -(maximumPosition - positionY) / bodyFollowDragFactor),
          child: body,
        ),
        dragContentBuilder(context, positionY, dragController, recognizer),
      ],
    );
  }
}
