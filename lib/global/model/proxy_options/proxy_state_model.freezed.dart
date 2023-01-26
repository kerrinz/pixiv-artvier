// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proxy_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProxyStateModel {
  /// 主机
  String get host => throw _privateConstructorUsedError;

  /// 端口
  String get port => throw _privateConstructorUsedError;

  /// 是否开启代理
  bool get isProxyEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProxyStateModelCopyWith<ProxyStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProxyStateModelCopyWith<$Res> {
  factory $ProxyStateModelCopyWith(
          ProxyStateModel value, $Res Function(ProxyStateModel) then) =
      _$ProxyStateModelCopyWithImpl<$Res, ProxyStateModel>;
  @useResult
  $Res call({String host, String port, bool isProxyEnabled});
}

/// @nodoc
class _$ProxyStateModelCopyWithImpl<$Res, $Val extends ProxyStateModel>
    implements $ProxyStateModelCopyWith<$Res> {
  _$ProxyStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? isProxyEnabled = null,
  }) {
    return _then(_value.copyWith(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as String,
      isProxyEnabled: null == isProxyEnabled
          ? _value.isProxyEnabled
          : isProxyEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProxyStateModelCopyWith<$Res>
    implements $ProxyStateModelCopyWith<$Res> {
  factory _$$_ProxyStateModelCopyWith(
          _$_ProxyStateModel value, $Res Function(_$_ProxyStateModel) then) =
      __$$_ProxyStateModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String host, String port, bool isProxyEnabled});
}

/// @nodoc
class __$$_ProxyStateModelCopyWithImpl<$Res>
    extends _$ProxyStateModelCopyWithImpl<$Res, _$_ProxyStateModel>
    implements _$$_ProxyStateModelCopyWith<$Res> {
  __$$_ProxyStateModelCopyWithImpl(
      _$_ProxyStateModel _value, $Res Function(_$_ProxyStateModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? isProxyEnabled = null,
  }) {
    return _then(_$_ProxyStateModel(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as String,
      isProxyEnabled: null == isProxyEnabled
          ? _value.isProxyEnabled
          : isProxyEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ProxyStateModel implements _ProxyStateModel {
  const _$_ProxyStateModel(
      {required this.host, required this.port, required this.isProxyEnabled});

  /// 主机
  @override
  final String host;

  /// 端口
  @override
  final String port;

  /// 是否开启代理
  @override
  final bool isProxyEnabled;

  @override
  String toString() {
    return 'ProxyStateModel(host: $host, port: $port, isProxyEnabled: $isProxyEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProxyStateModel &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.isProxyEnabled, isProxyEnabled) ||
                other.isProxyEnabled == isProxyEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, host, port, isProxyEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProxyStateModelCopyWith<_$_ProxyStateModel> get copyWith =>
      __$$_ProxyStateModelCopyWithImpl<_$_ProxyStateModel>(this, _$identity);
}

abstract class _ProxyStateModel implements ProxyStateModel {
  const factory _ProxyStateModel(
      {required final String host,
      required final String port,
      required final bool isProxyEnabled}) = _$_ProxyStateModel;

  @override

  /// 主机
  String get host;
  @override

  /// 端口
  String get port;
  @override

  /// 是否开启代理
  bool get isProxyEnabled;
  @override
  @JsonKey(ignore: true)
  _$$_ProxyStateModelCopyWith<_$_ProxyStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}
