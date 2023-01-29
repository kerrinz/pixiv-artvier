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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_ImageQualityUrlCopyWith<$Res>
    implements $ImageQualityUrlCopyWith<$Res> {
  factory _$$_ImageQualityUrlCopyWith(
          _$_ImageQualityUrl value, $Res Function(_$_ImageQualityUrl) then) =
      __$$_ImageQualityUrlCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String normal, String original});
}

/// @nodoc
class __$$_ImageQualityUrlCopyWithImpl<$Res>
    extends _$ImageQualityUrlCopyWithImpl<$Res, _$_ImageQualityUrl>
    implements _$$_ImageQualityUrlCopyWith<$Res> {
  __$$_ImageQualityUrlCopyWithImpl(
      _$_ImageQualityUrl _value, $Res Function(_$_ImageQualityUrl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? normal = null,
    Object? original = null,
  }) {
    return _then(_$_ImageQualityUrl(
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

class _$_ImageQualityUrl implements _ImageQualityUrl {
  const _$_ImageQualityUrl({required this.normal, required this.original});

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageQualityUrl &&
            (identical(other.normal, normal) || other.normal == normal) &&
            (identical(other.original, original) ||
                other.original == original));
  }

  @override
  int get hashCode => Object.hash(runtimeType, normal, original);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageQualityUrlCopyWith<_$_ImageQualityUrl> get copyWith =>
      __$$_ImageQualityUrlCopyWithImpl<_$_ImageQualityUrl>(this, _$identity);
}

abstract class _ImageQualityUrl implements ImageQualityUrl {
  const factory _ImageQualityUrl(
      {required final String normal,
      required final String original}) = _$_ImageQualityUrl;

  @override

  /// 普通画质
  String get normal;
  @override

  /// 原图画质
  String get original;
  @override
  @JsonKey(ignore: true)
  _$$_ImageQualityUrlCopyWith<_$_ImageQualityUrl> get copyWith =>
      throw _privateConstructorUsedError;
}
