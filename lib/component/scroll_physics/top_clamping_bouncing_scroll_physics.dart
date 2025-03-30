import 'package:flutter/cupertino.dart';

class TopClampingBouncingScrollPhysics extends BouncingScrollPhysics {
  const TopClampingBouncingScrollPhysics({super.parent});

  @override
  TopClampingBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return TopClampingBouncingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      // Underscroll.
      return value - position.pixels;
    }
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
      // Hit top edge.
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
      // Hit bottom edge.
      return value - position.maxScrollExtent;
    }
    return super.applyBoundaryConditions(position, value);
  }
}
