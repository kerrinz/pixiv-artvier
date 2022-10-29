import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/l10n/localization_intl.dart';

/// 请求数据的遮罩，根据[LoadingStatus]自动显示对应的遮罩内容
class RequestLoadMask extends StatelessWidget {
  /// 不能为[LoadingStatus.success]
  final LoadingStatus loadingStatus;

  /// 点击重试的事件
  final VoidCallback onRetry;

  const RequestLoadMask({
    Key? key,
    required this.loadingStatus,
    required this.onRetry,
  })  : assert(loadingStatus != LoadingStatus.success),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loadingStatus == LoadingStatus.loading) {
      return const RequestLoading();
    } else {
      return RequestLoadingFailed(onRetry: () {});
    }
  }
}

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
