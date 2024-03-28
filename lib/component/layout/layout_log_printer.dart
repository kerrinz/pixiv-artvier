import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LayoutLogPrint<T> extends StatelessWidget {
  /// This widget is quoted from https://book.flutterchina.club/chapter4/layoutbuilder.html#_4-8-1-layoutbuilder
  const LayoutLogPrint({
    super.key,
    this.tag,
    required this.child,
  });

  final Widget child;
  final T? tag; //指定日志tag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        if (kDebugMode) {
          print('${tag ?? key ?? child}: $constraints');
        }
        return true;
      }());
      return child;
    });
  }
}

class SliverLayoutLogPrint<T> extends StatelessWidget {
  /// This widget is quoted from https://book.flutterchina.club/chapter4/layoutbuilder.html#_4-8-1-layoutbuilder
  const SliverLayoutLogPrint({
    super.key,
    this.tag,
    required this.child,
  });

  final Widget child;
  final T? tag; //指定日志tag

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        if (kDebugMode) {
          print('${tag ?? key ?? child}: $constraints');
        }
        return true;
      }());
      return child;
    });
  }
}
