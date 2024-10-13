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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IllustDetailPageArguments {
  String get illustId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
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
  $Res call({String illustId, String? title, CommonIllust? detail});
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
    Object? title = freezed,
    Object? detail = freezed,
  }) {
    return _then(_value.copyWith(
      illustId: null == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as CommonIllust?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IllustDetailPageArgumentsImplCopyWith<$Res>
    implements $IllustDetailPageArgumentsCopyWith<$Res> {
  factory _$$IllustDetailPageArgumentsImplCopyWith(
          _$IllustDetailPageArgumentsImpl value,
          $Res Function(_$IllustDetailPageArgumentsImpl) then) =
      __$$IllustDetailPageArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String illustId, String? title, CommonIllust? detail});
}

/// @nodoc
class __$$IllustDetailPageArgumentsImplCopyWithImpl<$Res>
    extends _$IllustDetailPageArgumentsCopyWithImpl<$Res,
        _$IllustDetailPageArgumentsImpl>
    implements _$$IllustDetailPageArgumentsImplCopyWith<$Res> {
  __$$IllustDetailPageArgumentsImplCopyWithImpl(
      _$IllustDetailPageArgumentsImpl _value,
      $Res Function(_$IllustDetailPageArgumentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustId = null,
    Object? title = freezed,
    Object? detail = freezed,
  }) {
    return _then(_$IllustDetailPageArgumentsImpl(
      illustId: null == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as CommonIllust?,
    ));
  }
}

/// @nodoc

class _$IllustDetailPageArgumentsImpl implements _IllustDetailPageArguments {
  const _$IllustDetailPageArgumentsImpl(
      {required this.illustId, this.title, this.detail});

  @override
  final String illustId;
  @override
  final String? title;
  @override
  final CommonIllust? detail;

  @override
  String toString() {
    return 'IllustDetailPageArguments(illustId: $illustId, title: $title, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IllustDetailPageArgumentsImpl &&
            (identical(other.illustId, illustId) ||
                other.illustId == illustId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, illustId, title, detail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IllustDetailPageArgumentsImplCopyWith<_$IllustDetailPageArgumentsImpl>
      get copyWith => __$$IllustDetailPageArgumentsImplCopyWithImpl<
          _$IllustDetailPageArgumentsImpl>(this, _$identity);
}

abstract class _IllustDetailPageArguments implements IllustDetailPageArguments {
  const factory _IllustDetailPageArguments(
      {required final String illustId,
      final String? title,
      final CommonIllust? detail}) = _$IllustDetailPageArgumentsImpl;

  @override
  String get illustId;
  @override
  String? get title;
  @override
  CommonIllust? get detail;
  @override
  @JsonKey(ignore: true)
  _$$IllustDetailPageArgumentsImplCopyWith<_$IllustDetailPageArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
