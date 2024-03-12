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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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

  @JsonKey(ignore: true)
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
abstract class _$$_PixivisionWebViewPageArgumentsCopyWith<$Res>
    implements $PixivisionWebViewPageArgumentsCopyWith<$Res> {
  factory _$$_PixivisionWebViewPageArgumentsCopyWith(
          _$_PixivisionWebViewPageArguments value,
          $Res Function(_$_PixivisionWebViewPageArguments) then) =
      __$$_PixivisionWebViewPageArgumentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String language, int id, String title, String coverUrl});
}

/// @nodoc
class __$$_PixivisionWebViewPageArgumentsCopyWithImpl<$Res>
    extends _$PixivisionWebViewPageArgumentsCopyWithImpl<$Res,
        _$_PixivisionWebViewPageArguments>
    implements _$$_PixivisionWebViewPageArgumentsCopyWith<$Res> {
  __$$_PixivisionWebViewPageArgumentsCopyWithImpl(
      _$_PixivisionWebViewPageArguments _value,
      $Res Function(_$_PixivisionWebViewPageArguments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? id = null,
    Object? title = null,
    Object? coverUrl = null,
  }) {
    return _then(_$_PixivisionWebViewPageArguments(
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

class _$_PixivisionWebViewPageArguments
    implements _PixivisionWebViewPageArguments {
  const _$_PixivisionWebViewPageArguments(
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PixivisionWebViewPageArguments &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, language, id, title, coverUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PixivisionWebViewPageArgumentsCopyWith<_$_PixivisionWebViewPageArguments>
      get copyWith => __$$_PixivisionWebViewPageArgumentsCopyWithImpl<
          _$_PixivisionWebViewPageArguments>(this, _$identity);
}

abstract class _PixivisionWebViewPageArguments
    implements PixivisionWebViewPageArguments {
  const factory _PixivisionWebViewPageArguments(
      {required final String language,
      required final int id,
      required final String title,
      required final String coverUrl}) = _$_PixivisionWebViewPageArguments;

  @override

  /// 语言
  String get language;
  @override

  /// ID
  int get id;
  @override

  /// 作品标题
  String get title;
  @override

  /// 作品封面图链接
  String get coverUrl;
  @override
  @JsonKey(ignore: true)
  _$$_PixivisionWebViewPageArgumentsCopyWith<_$_PixivisionWebViewPageArguments>
      get copyWith => throw _privateConstructorUsedError;
}
