// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_hosting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageHostingModel {
  /// 图片源
  String get host => throw _privateConstructorUsedError;

  /// 是否开启自定义图片源
  bool get isEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageHostingModelCopyWith<ImageHostingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageHostingModelCopyWith<$Res> {
  factory $ImageHostingModelCopyWith(
          ImageHostingModel value, $Res Function(ImageHostingModel) then) =
      _$ImageHostingModelCopyWithImpl<$Res, ImageHostingModel>;
  @useResult
  $Res call({String host, bool isEnabled});
}

/// @nodoc
class _$ImageHostingModelCopyWithImpl<$Res, $Val extends ImageHostingModel>
    implements $ImageHostingModelCopyWith<$Res> {
  _$ImageHostingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? isEnabled = null,
  }) {
    return _then(_value.copyWith(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageHostingModelImplCopyWith<$Res>
    implements $ImageHostingModelCopyWith<$Res> {
  factory _$$ImageHostingModelImplCopyWith(_$ImageHostingModelImpl value,
          $Res Function(_$ImageHostingModelImpl) then) =
      __$$ImageHostingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String host, bool isEnabled});
}

/// @nodoc
class __$$ImageHostingModelImplCopyWithImpl<$Res>
    extends _$ImageHostingModelCopyWithImpl<$Res, _$ImageHostingModelImpl>
    implements _$$ImageHostingModelImplCopyWith<$Res> {
  __$$ImageHostingModelImplCopyWithImpl(_$ImageHostingModelImpl _value,
      $Res Function(_$ImageHostingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? isEnabled = null,
  }) {
    return _then(_$ImageHostingModelImpl(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ImageHostingModelImpl implements _ImageHostingModel {
  const _$ImageHostingModelImpl({required this.host, required this.isEnabled});

  /// 图片源
  @override
  final String host;

  /// 是否开启自定义图片源
  @override
  final bool isEnabled;

  @override
  String toString() {
    return 'ImageHostingModel(host: $host, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageHostingModelImpl &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, host, isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageHostingModelImplCopyWith<_$ImageHostingModelImpl> get copyWith =>
      __$$ImageHostingModelImplCopyWithImpl<_$ImageHostingModelImpl>(
          this, _$identity);
}

abstract class _ImageHostingModel implements ImageHostingModel {
  const factory _ImageHostingModel(
      {required final String host,
      required final bool isEnabled}) = _$ImageHostingModelImpl;

  @override

  /// 图片源
  String get host;
  @override

  /// 是否开启自定义图片源
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$ImageHostingModelImplCopyWith<_$ImageHostingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
