import 'package:flutter/widgets.dart';

class SingleLineFittedBox extends StatelessWidget {
  /// This widget is quoted from https://book.flutterchina.club/chapter5/fittedbox.html#_5-6-1-fittedbox
  const SingleLineFittedBox({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => FittedBox(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
            minWidth: constraints.maxWidth,
            maxWidth: double.infinity,
            // minHeight: constraints.maxHeight,
            // maxHeight: double.infinity,
          ),
          child: child,
        ),
      ),
    );
  }
}
