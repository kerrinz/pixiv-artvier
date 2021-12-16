import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
/// Provider的快捷创建组件
///
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget child;

  const ProviderWidget({required this.child, required this.model}) : super();

  @override
  State<StatefulWidget> createState() => ProviderWidgetState();
}

class ProviderWidgetState extends State<ProviderWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.model,
      child: widget.child,
    );
  }
}
