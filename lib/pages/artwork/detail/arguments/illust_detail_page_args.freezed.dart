// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'illust_detail_page_args.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IllustDetailPageArguments {
  String get illustId => throw _privateConstructorUsedError;
  CommonIllust? get detail => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IllustDetailPageArgumentsCopyWith<IllustDetailPageArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IllustDetailPageArgumentsCopyWith<$Res> {
  factory $IllustDetailPageArgumentsCopyWith(IllustDetailPageArguments value,
          $Res Function(IllustDetailPageArguments) then) =
      _$IllustDetailPageArgumentsCopyWithImpl<$Res, IllustDetailPageArguments>;
  @useResult
  $Res call({String illustId, CommonIllust? detail});
}

/// @nodoc
class _$IllustDetailPageArgumentsCopyWithImpl<$Res,
        $Val extends IllustDetailPageArguments>
    implements $IllustDetailPageArgumentsCopyWith<$Res> {
  _$IllustDetailPageArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustId = null,
    Object? detail = freezed,
  }) {
    return _then(_value.copyWith(
      illustId: null == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as CommonIllust?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IllustDetailPageArgumentsCopyWith<$Res>
    implements $IllustDetailPageArgumentsCopyWith<$Res> {
  factory _$$_IllustDetailPageArgumentsCopyWith(
          _$_IllustDetailPageArguments value,
          $Res Function(_$_IllustDetailPageArguments) then) =
      __$$_IllustDetailPageArgumentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String illustId, CommonIllust? detail});
}

/// @nodoc
class __$$_IllustDetailPageArgumentsCopyWithImpl<$Res>
    extends _$IllustDetailPageArgumentsCopyWithImpl<$Res,
        _$_IllustDetailPageArguments>
    implements _$$_IllustDetailPageArgumentsCopyWith<$Res> {
  __$$_IllustDetailPageArgumentsCopyWithImpl(
      _$_IllustDetailPageArguments _value,
      $Res Function(_$_IllustDetailPageArguments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustId = null,
    Object? detail = freezed,
  }) {
    return _then(_$_IllustDetailPageArguments(
      illustId: null == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as CommonIllust?,
    ));
  }
}

/// @nodoc

class _$_IllustDetailPageArguments implements _IllustDetailPageArguments {
  const _$_IllustDetailPageArguments(
      {required this.illustId, required this.detail});

  @override
  final String illustId;
  @override
  final CommonIllust? detail;

  @override
  String toString() {
    return 'IllustDetailPageArguments(illustId: $illustId, detail: $detail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IllustDetailPageArguments &&
            (identical(other.illustId, illustId) ||
                other.illustId == illustId) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, illustId, detail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IllustDetailPageArgumentsCopyWith<_$_IllustDetailPageArguments>
      get copyWith => __$$_IllustDetailPageArgumentsCopyWithImpl<
          _$_IllustDetailPageArguments>(this, _$identity);
}

abstract class _IllustDetailPageArguments implements IllustDetailPageArguments {
  const factory _IllustDetailPageArguments(
      {required final String illustId,
      required final CommonIllust? detail}) = _$_IllustDetailPageArguments;

  @override
  String get illustId;
  @override
  CommonIllust? get detail;
  @override
  @JsonKey(ignore: true)
  _$$_IllustDetailPageArgumentsCopyWith<_$_IllustDetailPageArguments>
      get copyWith => throw _privateConstructorUsedError;
}
