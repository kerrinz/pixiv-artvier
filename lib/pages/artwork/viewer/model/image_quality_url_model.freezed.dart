// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_quality_url_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageQualityUrl {
  /// 普通画质
  String get normal => throw _privateConstructorUsedError;

  /// 原图画质
  String get original => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageQualityUrlCopyWith<ImageQualityUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageQualityUrlCopyWith<$Res> {
  factory $ImageQualityUrlCopyWith(
          ImageQualityUrl value, $Res Function(ImageQualityUrl) then) =
      _$ImageQualityUrlCopyWithImpl<$Res, ImageQualityUrl>;
  @useResult
  $Res call({String normal, String original});
}

/// @nodoc
class _$ImageQualityUrlCopyWithImpl<$Res, $Val extends ImageQualityUrl>
    implements $ImageQualityUrlCopyWith<$Res> {
  _$ImageQualityUrlCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? normal = null,
    Object? original = null,
  }) {
    return _then(_value.copyWith(
      normal: null == normal
          ? _value.normal
          : normal // ignore: cast_nullable_to_non_nullable
              as String,
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageQualityUrlImplCopyWith<$Res>
    implements $ImageQualityUrlCopyWith<$Res> {
  factory _$$ImageQualityUrlImplCopyWith(_$ImageQualityUrlImpl value,
          $Res Function(_$ImageQualityUrlImpl) then) =
      __$$ImageQualityUrlImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String normal, String original});
}

/// @nodoc
class __$$ImageQualityUrlImplCopyWithImpl<$Res>
    extends _$ImageQualityUrlCopyWithImpl<$Res, _$ImageQualityUrlImpl>
    implements _$$ImageQualityUrlImplCopyWith<$Res> {
  __$$ImageQualityUrlImplCopyWithImpl(
      _$ImageQualityUrlImpl _value, $Res Function(_$ImageQualityUrlImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? normal = null,
    Object? original = null,
  }) {
    return _then(_$ImageQualityUrlImpl(
      normal: null == normal
          ? _value.normal
          : normal // ignore: cast_nullable_to_non_nullable
              as String,
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ImageQualityUrlImpl implements _ImageQualityUrl {
  const _$ImageQualityUrlImpl({required this.normal, required this.original});

  /// 普通画质
  @override
  final String normal;

  /// 原图画质
  @override
  final String original;

  @override
  String toString() {
    return 'ImageQualityUrl(normal: $normal, original: $original)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageQualityUrlImpl &&
            (identical(other.normal, normal) || other.normal == normal) &&
            (identical(other.original, original) ||
                other.original == original));
  }

  @override
  int get hashCode => Object.hash(runtimeType, normal, original);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageQualityUrlImplCopyWith<_$ImageQualityUrlImpl> get copyWith =>
      __$$ImageQualityUrlImplCopyWithImpl<_$ImageQualityUrlImpl>(
          this, _$identity);
}

abstract class _ImageQualityUrl implements ImageQualityUrl {
  const factory _ImageQualityUrl(
      {required final String normal,
      required final String original}) = _$ImageQualityUrlImpl;

  @override

  /// 普通画质
  String get normal;
  @override

  /// 原图画质
  String get original;
  @override
  @JsonKey(ignore: true)
  _$$ImageQualityUrlImplCopyWith<_$ImageQualityUrlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
