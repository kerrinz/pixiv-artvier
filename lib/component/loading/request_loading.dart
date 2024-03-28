import 'package:flutter/material.dart';
import 'package:artvier/l10n/localization_intl.dart';

/// 网络请求加载中显示的组件
class RequestLoading extends StatelessWidget {
  const RequestLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.asset("assets/image/page_loading.gif", height: 100),
          const Text("Loading..."),
        ],
      ),
    );
  }
}

/// 网络请求加载失败时显示的组件
class RequestLoadingFailed extends StatelessWidget {
  /// 点击重试的事件
  final VoidCallback onRetry;

  const RequestLoadingFailed({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Opacity(opacity: 0.75, child: Image.asset("assets/image/network_error.png", height: 100)),
          ),
          Text(LocalizationIntl.of(context).requestFailed),
          TextButton(onPressed: onRetry, child: Text(LocalizationIntl.of(context).retryOnFailure)),
        ],
      ),
    );
  }
}
