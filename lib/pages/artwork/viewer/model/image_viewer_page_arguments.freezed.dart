// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_viewer_page_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImageViewerPageArguments {
  /// 普通画质
  List<ImageQualityUrl> get urlList => throw _privateConstructorUsedError;

  /// 初始查看第几张图片
  int get index => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageViewerPageArgumentsCopyWith<ImageViewerPageArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageViewerPageArgumentsCopyWith<$Res> {
  factory $ImageViewerPageArgumentsCopyWith(ImageViewerPageArguments value,
          $Res Function(ImageViewerPageArguments) then) =
      _$ImageViewerPageArgumentsCopyWithImpl<$Res, ImageViewerPageArguments>;
  @useResult
  $Res call({List<ImageQualityUrl> urlList, int index});
}

/// @nodoc
class _$ImageViewerPageArgumentsCopyWithImpl<$Res,
        $Val extends ImageViewerPageArguments>
    implements $ImageViewerPageArgumentsCopyWith<$Res> {
  _$ImageViewerPageArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? urlList = null,
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      urlList: null == urlList
          ? _value.urlList
          : urlList // ignore: cast_nullable_to_non_nullable
              as List<ImageQualityUrl>,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageViewerPageArgumentsCopyWith<$Res>
    implements $ImageViewerPageArgumentsCopyWith<$Res> {
  factory _$$_ImageViewerPageArgumentsCopyWith(
          _$_ImageViewerPageArguments value,
          $Res Function(_$_ImageViewerPageArguments) then) =
      __$$_ImageViewerPageArgumentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ImageQualityUrl> urlList, int index});
}

/// @nodoc
class __$$_ImageViewerPageArgumentsCopyWithImpl<$Res>
    extends _$ImageViewerPageArgumentsCopyWithImpl<$Res,
        _$_ImageViewerPageArguments>
    implements _$$_ImageViewerPageArgumentsCopyWith<$Res> {
  __$$_ImageViewerPageArgumentsCopyWithImpl(_$_ImageViewerPageArguments _value,
      $Res Function(_$_ImageViewerPageArguments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? urlList = null,
    Object? index = null,
  }) {
    return _then(_$_ImageViewerPageArguments(
      urlList: null == urlList
          ? _value._urlList
          : urlList // ignore: cast_nullable_to_non_nullable
              as List<ImageQualityUrl>,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ImageViewerPageArguments implements _ImageViewerPageArguments {
  const _$_ImageViewerPageArguments(
      {required final List<ImageQualityUrl> urlList, required this.index})
      : _urlList = urlList;

  /// 普通画质
  final List<ImageQualityUrl> _urlList;

  /// 普通画质
  @override
  List<ImageQualityUrl> get urlList {
    if (_urlList is EqualUnmodifiableListView) return _urlList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urlList);
  }

  /// 初始查看第几张图片
  @override
  final int index;

  @override
  String toString() {
    return 'ImageViewerPageArguments(urlList: $urlList, index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageViewerPageArguments &&
            const DeepCollectionEquality().equals(other._urlList, _urlList) &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_urlList), index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageViewerPageArgumentsCopyWith<_$_ImageViewerPageArguments>
      get copyWith => __$$_ImageViewerPageArgumentsCopyWithImpl<
          _$_ImageViewerPageArguments>(this, _$identity);
}

abstract class _ImageViewerPageArguments implements ImageViewerPageArguments {
  const factory _ImageViewerPageArguments(
      {required final List<ImageQualityUrl> urlList,
      required final int index}) = _$_ImageViewerPageArguments;

  @override

  /// 普通画质
  List<ImageQualityUrl> get urlList;
  @override

  /// 初始查看第几张图片
  int get index;
  @override
  @JsonKey(ignore: true)
  _$$_ImageViewerPageArgumentsCopyWith<_$_ImageViewerPageArguments>
      get copyWith => throw _privateConstructorUsedError;
}
