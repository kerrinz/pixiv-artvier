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
  /// 搜索对象
  String? get searchTarget => throw _privateConstructorUsedError;

  /// AI
  int? get searchAiType => throw _privateConstructorUsedError;

  /// 最早日期
  String? get startDate => throw _privateConstructorUsedError;

  /// 最晚日期
  String? get endDate => throw _privateConstructorUsedError;

  /// 排序方式
  String get sort => throw _privateConstructorUsedError;

  /// 匹配规则
  String get match => throw _privateConstructorUsedError;

  /// 收藏数（标签、非会员）
  String? get bookmarkCountNotPremium => throw _privateConstructorUsedError;

  /// Create a copy of SearchFilterArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {String? searchTarget,
      int? searchAiType,
      String? startDate,
      String? endDate,
      String sort,
      String match,
      String? bookmarkCountNotPremium});
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

  /// Create a copy of SearchFilterArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchTarget = freezed,
    Object? searchAiType = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? sort = null,
    Object? match = null,
    Object? bookmarkCountNotPremium = freezed,
  }) {
    return _then(_value.copyWith(
      searchTarget: freezed == searchTarget
          ? _value.searchTarget
          : searchTarget // ignore: cast_nullable_to_non_nullable
              as String?,
      searchAiType: freezed == searchAiType
          ? _value.searchAiType
          : searchAiType // ignore: cast_nullable_to_non_nullable
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
      bookmarkCountNotPremium: freezed == bookmarkCountNotPremium
          ? _value.bookmarkCountNotPremium
          : bookmarkCountNotPremium // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {String? searchTarget,
      int? searchAiType,
      String? startDate,
      String? endDate,
      String sort,
      String match,
      String? bookmarkCountNotPremium});
}

/// @nodoc
class __$$SearchFilterArgumentsImplCopyWithImpl<$Res>
    extends _$SearchFilterArgumentsCopyWithImpl<$Res,
        _$SearchFilterArgumentsImpl>
    implements _$$SearchFilterArgumentsImplCopyWith<$Res> {
  __$$SearchFilterArgumentsImplCopyWithImpl(_$SearchFilterArgumentsImpl _value,
      $Res Function(_$SearchFilterArgumentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchFilterArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchTarget = freezed,
    Object? searchAiType = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? sort = null,
    Object? match = null,
    Object? bookmarkCountNotPremium = freezed,
  }) {
    return _then(_$SearchFilterArgumentsImpl(
      searchTarget: freezed == searchTarget
          ? _value.searchTarget
          : searchTarget // ignore: cast_nullable_to_non_nullable
              as String?,
      searchAiType: freezed == searchAiType
          ? _value.searchAiType
          : searchAiType // ignore: cast_nullable_to_non_nullable
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
      bookmarkCountNotPremium: freezed == bookmarkCountNotPremium
          ? _value.bookmarkCountNotPremium
          : bookmarkCountNotPremium // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SearchFilterArgumentsImpl implements _SearchFilterArguments {
  const _$SearchFilterArgumentsImpl(
      {this.searchTarget = ApiSearchConstants.tagPerfectMatch,
      this.searchAiType = 0,
      this.startDate,
      this.endDate,
      this.sort = ApiSearchConstants.dateDesc,
      this.match = ApiSearchConstants.tagPartialMatch,
      this.bookmarkCountNotPremium});

  /// 搜索对象
  @override
  @JsonKey()
  final String? searchTarget;

  /// AI
  @override
  @JsonKey()
  final int? searchAiType;

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

  /// 收藏数（标签、非会员）
  @override
  final String? bookmarkCountNotPremium;

  @override
  String toString() {
    return 'SearchFilterArguments(searchTarget: $searchTarget, searchAiType: $searchAiType, startDate: $startDate, endDate: $endDate, sort: $sort, match: $match, bookmarkCountNotPremium: $bookmarkCountNotPremium)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchFilterArgumentsImpl &&
            (identical(other.searchTarget, searchTarget) ||
                other.searchTarget == searchTarget) &&
            (identical(other.searchAiType, searchAiType) ||
                other.searchAiType == searchAiType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.match, match) || other.match == match) &&
            (identical(
                    other.bookmarkCountNotPremium, bookmarkCountNotPremium) ||
                other.bookmarkCountNotPremium == bookmarkCountNotPremium));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchTarget, searchAiType,
      startDate, endDate, sort, match, bookmarkCountNotPremium);

  /// Create a copy of SearchFilterArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchFilterArgumentsImplCopyWith<_$SearchFilterArgumentsImpl>
      get copyWith => __$$SearchFilterArgumentsImplCopyWithImpl<
          _$SearchFilterArgumentsImpl>(this, _$identity);
}

abstract class _SearchFilterArguments implements SearchFilterArguments {
  const factory _SearchFilterArguments(
      {final String? searchTarget,
      final int? searchAiType,
      final String? startDate,
      final String? endDate,
      final String sort,
      final String match,
      final String? bookmarkCountNotPremium}) = _$SearchFilterArgumentsImpl;

  /// 搜索对象
  @override
  String? get searchTarget;

  /// AI
  @override
  int? get searchAiType;

  /// 最早日期
  @override
  String? get startDate;

  /// 最晚日期
  @override
  String? get endDate;

  /// 排序方式
  @override
  String get sort;

  /// 匹配规则
  @override
  String get match;

  /// 收藏数（标签、非会员）
  @override
  String? get bookmarkCountNotPremium;

  /// Create a copy of SearchFilterArguments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchFilterArgumentsImplCopyWith<_$SearchFilterArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
