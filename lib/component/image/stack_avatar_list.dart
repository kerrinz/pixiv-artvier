import 'package:flutter/widgets.dart';

class StackAvatarList extends StatelessWidget {
  const StackAvatarList({
    super.key,
    required this.itemWidth,
    required this.offset,
    required this.itemBuilder,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    this.itemCount,
  }) : assert(offset >= 0);

  final double itemWidth;

  /// 偏移量，类似负数的 margin
  final double offset;
  final NullableIndexedWidgetBuilder itemBuilder;
  final bool reverse;
  final int? itemCount;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: offset / 2),
      scrollDirection: scrollDirection,
      reverse: reverse,
      itemBuilder: (context, index) {
        return SizedBox(
          width: itemWidth - offset,
          child: FittedBox(
            fit: BoxFit.none,
            child: SizedBox(
              width: itemWidth,
              height: itemWidth,
              child: itemBuilder(context, index),
            ),
          ),
        );
      },
      itemCount: itemCount,
    );
  }
}
