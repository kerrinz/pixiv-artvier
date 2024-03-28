// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pixivision_body_illust_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PixivisionBodyIllustItem {
  /// 作品名
  String get illustTitle => throw _privateConstructorUsedError;

  /// 作品ID
  String get illustId => throw _privateConstructorUsedError;

  /// 图片地址
  String get illustUrl => throw _privateConstructorUsedError;

  /// 作者名
  String get authorName => throw _privateConstructorUsedError;

  /// 作者头像
  String get authorAvatar => throw _privateConstructorUsedError;

  /// 作者Id
  String get authorId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PixivisionBodyIllustItemCopyWith<PixivisionBodyIllustItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PixivisionBodyIllustItemCopyWith<$Res> {
  factory $PixivisionBodyIllustItemCopyWith(PixivisionBodyIllustItem value,
          $Res Function(PixivisionBodyIllustItem) then) =
      _$PixivisionBodyIllustItemCopyWithImpl<$Res, PixivisionBodyIllustItem>;
  @useResult
  $Res call(
      {String illustTitle,
      String illustId,
      String illustUrl,
      String authorName,
      String authorAvatar,
      String authorId});
}

/// @nodoc
class _$PixivisionBodyIllustItemCopyWithImpl<$Res,
        $Val extends PixivisionBodyIllustItem>
    implements $PixivisionBodyIllustItemCopyWith<$Res> {
  _$PixivisionBodyIllustItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustTitle = null,
    Object? illustId = null,
    Object? illustUrl = null,
    Object? authorName = null,
    Object? authorAvatar = null,
    Object? authorId = null,
  }) {
    return _then(_value.copyWith(
      illustTitle: null == illustTitle
          ? _value.illustTitle
          : illustTitle // ignore: cast_nullable_to_non_nullable
              as String,
      illustId: null == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String,
      illustUrl: null == illustUrl
          ? _value.illustUrl
          : illustUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatar: null == authorAvatar
          ? _value.authorAvatar
          : authorAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PixivisionBodyIllustItemImplCopyWith<$Res>
    implements $PixivisionBodyIllustItemCopyWith<$Res> {
  factory _$$PixivisionBodyIllustItemImplCopyWith(
          _$PixivisionBodyIllustItemImpl value,
          $Res Function(_$PixivisionBodyIllustItemImpl) then) =
      __$$PixivisionBodyIllustItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String illustTitle,
      String illustId,
      String illustUrl,
      String authorName,
      String authorAvatar,
      String authorId});
}

/// @nodoc
class __$$PixivisionBodyIllustItemImplCopyWithImpl<$Res>
    extends _$PixivisionBodyIllustItemCopyWithImpl<$Res,
        _$PixivisionBodyIllustItemImpl>
    implements _$$PixivisionBodyIllustItemImplCopyWith<$Res> {
  __$$PixivisionBodyIllustItemImplCopyWithImpl(
      _$PixivisionBodyIllustItemImpl _value,
      $Res Function(_$PixivisionBodyIllustItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustTitle = null,
    Object? illustId = null,
    Object? illustUrl = null,
    Object? authorName = null,
    Object? authorAvatar = null,
    Object? authorId = null,
  }) {
    return _then(_$PixivisionBodyIllustItemImpl(
      illustTitle: null == illustTitle
          ? _value.illustTitle
          : illustTitle // ignore: cast_nullable_to_non_nullable
              as String,
      illustId: null == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String,
      illustUrl: null == illustUrl
          ? _value.illustUrl
          : illustUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatar: null == authorAvatar
          ? _value.authorAvatar
          : authorAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PixivisionBodyIllustItemImpl implements _PixivisionBodyIllustItem {
  const _$PixivisionBodyIllustItemImpl(
      {required this.illustTitle,
      required this.illustId,
      required this.illustUrl,
      required this.authorName,
      required this.authorAvatar,
      required this.authorId});

  /// 作品名
  @override
  final String illustTitle;

  /// 作品ID
  @override
  final String illustId;

  /// 图片地址
  @override
  final String illustUrl;

  /// 作者名
  @override
  final String authorName;

  /// 作者头像
  @override
  final String authorAvatar;

  /// 作者Id
  @override
  final String authorId;

  @override
  String toString() {
    return 'PixivisionBodyIllustItem(illustTitle: $illustTitle, illustId: $illustId, illustUrl: $illustUrl, authorName: $authorName, authorAvatar: $authorAvatar, authorId: $authorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PixivisionBodyIllustItemImpl &&
            (identical(other.illustTitle, illustTitle) ||
                other.illustTitle == illustTitle) &&
            (identical(other.illustId, illustId) ||
                other.illustId == illustId) &&
            (identical(other.illustUrl, illustUrl) ||
                other.illustUrl == illustUrl) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorAvatar, authorAvatar) ||
                other.authorAvatar == authorAvatar) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, illustTitle, illustId, illustUrl,
      authorName, authorAvatar, authorId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PixivisionBodyIllustItemImplCopyWith<_$PixivisionBodyIllustItemImpl>
      get copyWith => __$$PixivisionBodyIllustItemImplCopyWithImpl<
          _$PixivisionBodyIllustItemImpl>(this, _$identity);
}

abstract class _PixivisionBodyIllustItem implements PixivisionBodyIllustItem {
  const factory _PixivisionBodyIllustItem(
      {required final String illustTitle,
      required final String illustId,
      required final String illustUrl,
      required final String authorName,
      required final String authorAvatar,
      required final String authorId}) = _$PixivisionBodyIllustItemImpl;

  @override

  /// 作品名
  String get illustTitle;
  @override

  /// 作品ID
  String get illustId;
  @override

  /// 图片地址
  String get illustUrl;
  @override

  /// 作者名
  String get authorName;
  @override

  /// 作者头像
  String get authorAvatar;
  @override

  /// 作者Id
  String get authorId;
  @override
  @JsonKey(ignore: true)
  _$$PixivisionBodyIllustItemImplCopyWith<_$PixivisionBodyIllustItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
