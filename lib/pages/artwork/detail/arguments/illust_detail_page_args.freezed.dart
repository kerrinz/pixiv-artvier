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
// 单个作品 ID
  String? get illustId => throw _privateConstructorUsedError; // 单个作品标题
  String? get title => throw _privateConstructorUsedError; // 多个作品完整信息
  List<CommonIllust>? get illustList =>
      throw _privateConstructorUsedError; // 多个作品中，当前作品的索引
  int? get currentIllustListIndex => throw _privateConstructorUsedError;

  /// Create a copy of IllustDetailPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IllustDetailPageArgumentsCopyWith<IllustDetailPageArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IllustDetailPageArgumentsCopyWith<$Res> {
  factory $IllustDetailPageArgumentsCopyWith(IllustDetailPageArguments value,
          $Res Function(IllustDetailPageArguments) then) =
      _$IllustDetailPageArgumentsCopyWithImpl<$Res, IllustDetailPageArguments>;
  @useResult
  $Res call(
      {String? illustId,
      String? title,
      List<CommonIllust>? illustList,
      int? currentIllustListIndex});
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

  /// Create a copy of IllustDetailPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustId = freezed,
    Object? title = freezed,
    Object? illustList = freezed,
    Object? currentIllustListIndex = freezed,
  }) {
    return _then(_value.copyWith(
      illustId: freezed == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      illustList: freezed == illustList
          ? _value.illustList
          : illustList // ignore: cast_nullable_to_non_nullable
              as List<CommonIllust>?,
      currentIllustListIndex: freezed == currentIllustListIndex
          ? _value.currentIllustListIndex
          : currentIllustListIndex // ignore: cast_nullable_to_non_nullable
              as int?,
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
  $Res call(
      {String? illustId,
      String? title,
      List<CommonIllust>? illustList,
      int? currentIllustListIndex});
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

  /// Create a copy of IllustDetailPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustId = freezed,
    Object? title = freezed,
    Object? illustList = freezed,
    Object? currentIllustListIndex = freezed,
  }) {
    return _then(_$IllustDetailPageArgumentsImpl(
      illustId: freezed == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      illustList: freezed == illustList
          ? _value._illustList
          : illustList // ignore: cast_nullable_to_non_nullable
              as List<CommonIllust>?,
      currentIllustListIndex: freezed == currentIllustListIndex
          ? _value.currentIllustListIndex
          : currentIllustListIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$IllustDetailPageArgumentsImpl implements _IllustDetailPageArguments {
  const _$IllustDetailPageArgumentsImpl(
      {this.illustId,
      this.title,
      final List<CommonIllust>? illustList,
      this.currentIllustListIndex})
      : _illustList = illustList;

// 单个作品 ID
  @override
  final String? illustId;
// 单个作品标题
  @override
  final String? title;
// 多个作品完整信息
  final List<CommonIllust>? _illustList;
// 多个作品完整信息
  @override
  List<CommonIllust>? get illustList {
    final value = _illustList;
    if (value == null) return null;
    if (_illustList is EqualUnmodifiableListView) return _illustList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// 多个作品中，当前作品的索引
  @override
  final int? currentIllustListIndex;

  @override
  String toString() {
    return 'IllustDetailPageArguments(illustId: $illustId, title: $title, illustList: $illustList, currentIllustListIndex: $currentIllustListIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IllustDetailPageArgumentsImpl &&
            (identical(other.illustId, illustId) ||
                other.illustId == illustId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._illustList, _illustList) &&
            (identical(other.currentIllustListIndex, currentIllustListIndex) ||
                other.currentIllustListIndex == currentIllustListIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, illustId, title,
      const DeepCollectionEquality().hash(_illustList), currentIllustListIndex);

  /// Create a copy of IllustDetailPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IllustDetailPageArgumentsImplCopyWith<_$IllustDetailPageArgumentsImpl>
      get copyWith => __$$IllustDetailPageArgumentsImplCopyWithImpl<
          _$IllustDetailPageArgumentsImpl>(this, _$identity);
}

abstract class _IllustDetailPageArguments implements IllustDetailPageArguments {
  const factory _IllustDetailPageArguments(
      {final String? illustId,
      final String? title,
      final List<CommonIllust>? illustList,
      final int? currentIllustListIndex}) = _$IllustDetailPageArgumentsImpl;

// 单个作品 ID
  @override
  String? get illustId; // 单个作品标题
  @override
  String? get title; // 多个作品完整信息
  @override
  List<CommonIllust>? get illustList; // 多个作品中，当前作品的索引
  @override
  int? get currentIllustListIndex;

  /// Create a copy of IllustDetailPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IllustDetailPageArgumentsImplCopyWith<_$IllustDetailPageArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
