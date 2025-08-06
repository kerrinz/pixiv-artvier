// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pixivision_webview_page_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PixivisionWebViewPageArguments {
  /// 语言
  String get language => throw _privateConstructorUsedError;

  /// ID
  int get id => throw _privateConstructorUsedError;

  /// 作品标题
  String get title => throw _privateConstructorUsedError;

  /// 作品封面图链接
  String get coverUrl => throw _privateConstructorUsedError;

  /// Create a copy of PixivisionWebViewPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PixivisionWebViewPageArgumentsCopyWith<PixivisionWebViewPageArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PixivisionWebViewPageArgumentsCopyWith<$Res> {
  factory $PixivisionWebViewPageArgumentsCopyWith(
          PixivisionWebViewPageArguments value,
          $Res Function(PixivisionWebViewPageArguments) then) =
      _$PixivisionWebViewPageArgumentsCopyWithImpl<$Res,
          PixivisionWebViewPageArguments>;
  @useResult
  $Res call({String language, int id, String title, String coverUrl});
}

/// @nodoc
class _$PixivisionWebViewPageArgumentsCopyWithImpl<$Res,
        $Val extends PixivisionWebViewPageArguments>
    implements $PixivisionWebViewPageArgumentsCopyWith<$Res> {
  _$PixivisionWebViewPageArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PixivisionWebViewPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? id = null,
    Object? title = null,
    Object? coverUrl = null,
  }) {
    return _then(_value.copyWith(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PixivisionWebViewPageArgumentsImplCopyWith<$Res>
    implements $PixivisionWebViewPageArgumentsCopyWith<$Res> {
  factory _$$PixivisionWebViewPageArgumentsImplCopyWith(
          _$PixivisionWebViewPageArgumentsImpl value,
          $Res Function(_$PixivisionWebViewPageArgumentsImpl) then) =
      __$$PixivisionWebViewPageArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String language, int id, String title, String coverUrl});
}

/// @nodoc
class __$$PixivisionWebViewPageArgumentsImplCopyWithImpl<$Res>
    extends _$PixivisionWebViewPageArgumentsCopyWithImpl<$Res,
        _$PixivisionWebViewPageArgumentsImpl>
    implements _$$PixivisionWebViewPageArgumentsImplCopyWith<$Res> {
  __$$PixivisionWebViewPageArgumentsImplCopyWithImpl(
      _$PixivisionWebViewPageArgumentsImpl _value,
      $Res Function(_$PixivisionWebViewPageArgumentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PixivisionWebViewPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? id = null,
    Object? title = null,
    Object? coverUrl = null,
  }) {
    return _then(_$PixivisionWebViewPageArgumentsImpl(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PixivisionWebViewPageArgumentsImpl
    implements _PixivisionWebViewPageArguments {
  const _$PixivisionWebViewPageArgumentsImpl(
      {required this.language,
      required this.id,
      required this.title,
      required this.coverUrl});

  /// 语言
  @override
  final String language;

  /// ID
  @override
  final int id;

  /// 作品标题
  @override
  final String title;

  /// 作品封面图链接
  @override
  final String coverUrl;

  @override
  String toString() {
    return 'PixivisionWebViewPageArguments(language: $language, id: $id, title: $title, coverUrl: $coverUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PixivisionWebViewPageArgumentsImpl &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, language, id, title, coverUrl);

  /// Create a copy of PixivisionWebViewPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PixivisionWebViewPageArgumentsImplCopyWith<
          _$PixivisionWebViewPageArgumentsImpl>
      get copyWith => __$$PixivisionWebViewPageArgumentsImplCopyWithImpl<
          _$PixivisionWebViewPageArgumentsImpl>(this, _$identity);
}

abstract class _PixivisionWebViewPageArguments
    implements PixivisionWebViewPageArguments {
  const factory _PixivisionWebViewPageArguments(
      {required final String language,
      required final int id,
      required final String title,
      required final String coverUrl}) = _$PixivisionWebViewPageArgumentsImpl;

  /// 语言
  @override
  String get language;

  /// ID
  @override
  int get id;

  /// 作品标题
  @override
  String get title;

  /// 作品封面图链接
  @override
  String get coverUrl;

  /// Create a copy of PixivisionWebViewPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PixivisionWebViewPageArgumentsImplCopyWith<
          _$PixivisionWebViewPageArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
