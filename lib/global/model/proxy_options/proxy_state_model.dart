import 'package:freezed_annotation/freezed_annotation.dart';

part 'proxy_state_model.freezed.dart';

/// 代理的相关配置模型
@Freezed(
  copyWith: true,
)
class ProxyStateModel with _$ProxyStateModel {
  const factory ProxyStateModel({
    /// 主机
    required String host,

    /// 端口
    required String port,

    /// 是否开启代理
    required bool isProxyEnabled,
  }) = _ProxyStateModel;
}
