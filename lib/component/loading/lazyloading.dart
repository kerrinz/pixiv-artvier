import 'package:flutter/material.dart';
import 'package:artvier/l10n/localization_intl.dart';

class LazyloadingWidget extends StatelessWidget {
  const LazyloadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(strokeWidth: 1.0),
    );
  }
}

class LazyloadingFailedWidget extends StatelessWidget {
  /// 点击重试的事件
  final VoidCallback onRetry;

  const LazyloadingFailedWidget({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        Text(LocalizationIntl.of(context).requestFailed),
        TextButton(onPressed: onRetry, child: Text(LocalizationIntl.of(context).retryOnFailure)),
      ],
    );
  }
}
