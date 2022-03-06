import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
/// Provider快捷创建组件，内置Consumer
/// 示例：
/// ProviderWidget<XXXProvider>(
///   model: XXXProvider(),
///   builder: (BuildContext context, XXXProvider value, Widget? child) {
///     return Text(value.text);
///   },
/// ),
///
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget Function(
    BuildContext context,
    T value,
    Widget? child,
  ) builder;
  final Widget? child;

  const ProviderWidget({Key? key, required this.model, required this.builder, this.child}) : super(key: key);

  @override
  ProviderWidgetState<T> createState() => ProviderWidgetState<T>();
}

class ProviderWidgetState<T extends ChangeNotifier> extends State<ProviderWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.model.dispose();
  }
}
