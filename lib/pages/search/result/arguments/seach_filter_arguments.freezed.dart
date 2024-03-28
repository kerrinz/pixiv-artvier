// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seach_filter_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchFilterArguments {
  /// 最小收藏数筛选
  int? get minCollectCount => throw _privateConstructorUsedError;

  /// 最早日期
  String? get startDate => throw _privateConstructorUsedError;

  /// 最晚日期
  String? get endDate => throw _privateConstructorUsedError;

  /// 排序方式
  String get sort => throw _privateConstructorUsedError;

  /// 匹配规则
  String get match => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchFilterArgumentsCopyWith<SearchFilterArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchFilterArgumentsCopyWith<$Res> {
  factory $SearchFilterArgumentsCopyWith(SearchFilterArguments value,
          $Res Function(SearchFilterArguments) then) =
      _$SearchFilterArgumentsCopyWithImpl<$Res, SearchFilterArguments>;
  @useResult
  $Res call(
      {int? minCollectCount,
      String? startDate,
      String? endDate,
      String sort,
      String match});
}

/// @nodoc
class _$SearchFilterArgumentsCopyWithImpl<$Res,
        $Val extends SearchFilterArguments>
    implements $SearchFilterArgumentsCopyWith<$Res> {
  _$SearchFilterArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minCollectCount = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? sort = null,
    Object? match = null,
  }) {
    return _then(_value.copyWith(
      minCollectCount: freezed == minCollectCount
          ? _value.minCollectCount
          : minCollectCount // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as String,
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchFilterArgumentsImplCopyWith<$Res>
    implements $SearchFilterArgumentsCopyWith<$Res> {
  factory _$$SearchFilterArgumentsImplCopyWith(
          _$SearchFilterArgumentsImpl value,
          $Res Function(_$SearchFilterArgumentsImpl) then) =
      __$$SearchFilterArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? minCollectCount,
      String? startDate,
      String? endDate,
      String sort,
      String match});
}

/// @nodoc
class __$$SearchFilterArgumentsImplCopyWithImpl<$Res>
    extends _$SearchFilterArgumentsCopyWithImpl<$Res,
        _$SearchFilterArgumentsImpl>
    implements _$$SearchFilterArgumentsImplCopyWith<$Res> {
  __$$SearchFilterArgumentsImplCopyWithImpl(_$SearchFilterArgumentsImpl _value,
      $Res Function(_$SearchFilterArgumentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minCollectCount = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? sort = null,
    Object? match = null,
  }) {
    return _then(_$SearchFilterArgumentsImpl(
      minCollectCount: freezed == minCollectCount
          ? _value.minCollectCount
          : minCollectCount // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as String,
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchFilterArgumentsImpl implements _SearchFilterArguments {
  const _$SearchFilterArgumentsImpl(
      {this.minCollectCount,
      this.startDate,
      this.endDate,
      this.sort = ApiSearchConstants.dateDesc,
      this.match = ApiSearchConstants.tagPartialMatch});

  /// 最小收藏数筛选
  @override
  final int? minCollectCount;

  /// 最早日期
  @override
  final String? startDate;

  /// 最晚日期
  @override
  final String? endDate;

  /// 排序方式
  @override
  @JsonKey()
  final String sort;

  /// 匹配规则
  @override
  @JsonKey()
  final String match;

  @override
  String toString() {
    return 'SearchFilterArguments(minCollectCount: $minCollectCount, startDate: $startDate, endDate: $endDate, sort: $sort, match: $match)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchFilterArgumentsImpl &&
            (identical(other.minCollectCount, minCollectCount) ||
                other.minCollectCount == minCollectCount) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.match, match) || other.match == match));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, minCollectCount, startDate, endDate, sort, match);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchFilterArgumentsImplCopyWith<_$SearchFilterArgumentsImpl>
      get copyWith => __$$SearchFilterArgumentsImplCopyWithImpl<
          _$SearchFilterArgumentsImpl>(this, _$identity);
}

abstract class _SearchFilterArguments implements SearchFilterArguments {
  const factory _SearchFilterArguments(
      {final int? minCollectCount,
      final String? startDate,
      final String? endDate,
      final String sort,
      final String match}) = _$SearchFilterArgumentsImpl;

  @override

  /// 最小收藏数筛选
  int? get minCollectCount;
  @override

  /// 最早日期
  String? get startDate;
  @override

  /// 最晚日期
  String? get endDate;
  @override

  /// 排序方式
  String get sort;
  @override

  /// 匹配规则
  String get match;
  @override
  @JsonKey(ignore: true)
  _$$SearchFilterArgumentsImplCopyWith<_$SearchFilterArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
