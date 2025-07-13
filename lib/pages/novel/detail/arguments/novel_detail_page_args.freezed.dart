// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_detail_page_args.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NovelDetailPageArguments {
  String get novelId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  CommonNovel? get detail => throw _privateConstructorUsedError;

  /// 前往第几章节
  int? get toPage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NovelDetailPageArgumentsCopyWith<NovelDetailPageArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelDetailPageArgumentsCopyWith<$Res> {
  factory $NovelDetailPageArgumentsCopyWith(NovelDetailPageArguments value,
          $Res Function(NovelDetailPageArguments) then) =
      _$NovelDetailPageArgumentsCopyWithImpl<$Res, NovelDetailPageArguments>;
  @useResult
  $Res call({String novelId, String? title, CommonNovel? detail, int? toPage});
}

/// @nodoc
class _$NovelDetailPageArgumentsCopyWithImpl<$Res,
        $Val extends NovelDetailPageArguments>
    implements $NovelDetailPageArgumentsCopyWith<$Res> {
  _$NovelDetailPageArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novelId = null,
    Object? title = freezed,
    Object? detail = freezed,
    Object? toPage = freezed,
  }) {
    return _then(_value.copyWith(
      novelId: null == novelId
          ? _value.novelId
          : novelId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as CommonNovel?,
      toPage: freezed == toPage
          ? _value.toPage
          : toPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovelDetailPageArgumentsImplCopyWith<$Res>
    implements $NovelDetailPageArgumentsCopyWith<$Res> {
  factory _$$NovelDetailPageArgumentsImplCopyWith(
          _$NovelDetailPageArgumentsImpl value,
          $Res Function(_$NovelDetailPageArgumentsImpl) then) =
      __$$NovelDetailPageArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String novelId, String? title, CommonNovel? detail, int? toPage});
}

/// @nodoc
class __$$NovelDetailPageArgumentsImplCopyWithImpl<$Res>
    extends _$NovelDetailPageArgumentsCopyWithImpl<$Res,
        _$NovelDetailPageArgumentsImpl>
    implements _$$NovelDetailPageArgumentsImplCopyWith<$Res> {
  __$$NovelDetailPageArgumentsImplCopyWithImpl(
      _$NovelDetailPageArgumentsImpl _value,
      $Res Function(_$NovelDetailPageArgumentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novelId = null,
    Object? title = freezed,
    Object? detail = freezed,
    Object? toPage = freezed,
  }) {
    return _then(_$NovelDetailPageArgumentsImpl(
      novelId: null == novelId
          ? _value.novelId
          : novelId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as CommonNovel?,
      toPage: freezed == toPage
          ? _value.toPage
          : toPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$NovelDetailPageArgumentsImpl implements _NovelDetailPageArguments {
  const _$NovelDetailPageArgumentsImpl(
      {required this.novelId, this.title, this.detail, this.toPage});

  @override
  final String novelId;
  @override
  final String? title;
  @override
  final CommonNovel? detail;

  /// 前往第几章节
  @override
  final int? toPage;

  @override
  String toString() {
    return 'NovelDetailPageArguments(novelId: $novelId, title: $title, detail: $detail, toPage: $toPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelDetailPageArgumentsImpl &&
            (identical(other.novelId, novelId) || other.novelId == novelId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.toPage, toPage) || other.toPage == toPage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, novelId, title, detail, toPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelDetailPageArgumentsImplCopyWith<_$NovelDetailPageArgumentsImpl>
      get copyWith => __$$NovelDetailPageArgumentsImplCopyWithImpl<
          _$NovelDetailPageArgumentsImpl>(this, _$identity);
}

abstract class _NovelDetailPageArguments implements NovelDetailPageArguments {
  const factory _NovelDetailPageArguments(
      {required final String novelId,
      final String? title,
      final CommonNovel? detail,
      final int? toPage}) = _$NovelDetailPageArgumentsImpl;

  @override
  String get novelId;
  @override
  String? get title;
  @override
  CommonNovel? get detail;
  @override

  /// 前往第几章节
  int? get toPage;
  @override
  @JsonKey(ignore: true)
  _$$NovelDetailPageArgumentsImplCopyWith<_$NovelDetailPageArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
