import 'package:flutter/material.dart';
import 'package:artvier/l10n/localization_intl.dart';

class RequestLoading extends StatelessWidget {
  const RequestLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(strokeWidth: 1.0),
    );
  }
}

class RequestLoadingFailed extends StatelessWidget {
  /// 点击重试的事件
  final VoidCallback onRetry;

  const RequestLoadingFailed({
    Key? key,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        Text(LocalizationIntl.of(context).requestFailed),
        TextButton(onPressed: onRetry, child: Text(LocalizationIntl.of(context).retry)),
      ],
    );
  }
}
