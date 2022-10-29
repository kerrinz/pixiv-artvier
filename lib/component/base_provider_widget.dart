import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/base_provider.dart';
import 'package:provider/provider.dart';

/// Provider快捷创建组件，内置Consumer
/// 建议只给 [model] 传 [T()]，Provider的生命周期由本组件代为管理
/// 
/// 示例：
/// ProviderWidget<XXXProvider>(
///   model: XXXProvider(),
///   builder: (BuildContext context, XXXProvider value, Widget? child) {
///     return Text(value.text);
///   },
/// ),
///
class ProviderWidget<T extends BaseProvider> extends StatefulWidget {
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

class ProviderWidgetState<T extends BaseProvider> extends State<ProviderWidget<T>> {
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

/// Provider快捷创建组件，内置Consumer
/// 
/// 请勿直接给 [model] 传 [T()]，应当在外部定义T的变量，并控制其生命周期，本组件不管理Provider的生命周期
class ProviderStatelessWidget<T extends BaseProvider> extends StatelessWidget {
  final T model;
  final Widget Function(
    BuildContext context,
    T value,
    Widget? child,
  ) builder;
  final Widget? child;

  const ProviderStatelessWidget({Key? key, required this.model, required this.builder, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: builder,
        child: child,
      ),
    );
  }
}