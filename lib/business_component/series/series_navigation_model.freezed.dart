// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'series_navigation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SeriesNavigationModel {
  bool get seriesIsWatched => throw _privateConstructorUsedError;
  LoadState get loadstate => throw _privateConstructorUsedError;

  /// Create a copy of SeriesNavigationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeriesNavigationModelCopyWith<SeriesNavigationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesNavigationModelCopyWith<$Res> {
  factory $SeriesNavigationModelCopyWith(SeriesNavigationModel value,
          $Res Function(SeriesNavigationModel) then) =
      _$SeriesNavigationModelCopyWithImpl<$Res, SeriesNavigationModel>;
  @useResult
  $Res call({bool seriesIsWatched, LoadState loadstate});
}

/// @nodoc
class _$SeriesNavigationModelCopyWithImpl<$Res,
        $Val extends SeriesNavigationModel>
    implements $SeriesNavigationModelCopyWith<$Res> {
  _$SeriesNavigationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeriesNavigationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seriesIsWatched = null,
    Object? loadstate = null,
  }) {
    return _then(_value.copyWith(
      seriesIsWatched: null == seriesIsWatched
          ? _value.seriesIsWatched
          : seriesIsWatched // ignore: cast_nullable_to_non_nullable
              as bool,
      loadstate: null == loadstate
          ? _value.loadstate
          : loadstate // ignore: cast_nullable_to_non_nullable
              as LoadState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeriesNavigationModelImplCopyWith<$Res>
    implements $SeriesNavigationModelCopyWith<$Res> {
  factory _$$SeriesNavigationModelImplCopyWith(
          _$SeriesNavigationModelImpl value,
          $Res Function(_$SeriesNavigationModelImpl) then) =
      __$$SeriesNavigationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool seriesIsWatched, LoadState loadstate});
}

/// @nodoc
class __$$SeriesNavigationModelImplCopyWithImpl<$Res>
    extends _$SeriesNavigationModelCopyWithImpl<$Res,
        _$SeriesNavigationModelImpl>
    implements _$$SeriesNavigationModelImplCopyWith<$Res> {
  __$$SeriesNavigationModelImplCopyWithImpl(_$SeriesNavigationModelImpl _value,
      $Res Function(_$SeriesNavigationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SeriesNavigationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seriesIsWatched = null,
    Object? loadstate = null,
  }) {
    return _then(_$SeriesNavigationModelImpl(
      seriesIsWatched: null == seriesIsWatched
          ? _value.seriesIsWatched
          : seriesIsWatched // ignore: cast_nullable_to_non_nullable
              as bool,
      loadstate: null == loadstate
          ? _value.loadstate
          : loadstate // ignore: cast_nullable_to_non_nullable
              as LoadState,
    ));
  }
}

/// @nodoc

class _$SeriesNavigationModelImpl implements _SeriesNavigationModel {
  const _$SeriesNavigationModelImpl(
      {required this.seriesIsWatched, required this.loadstate});

  @override
  final bool seriesIsWatched;
  @override
  final LoadState loadstate;

  @override
  String toString() {
    return 'SeriesNavigationModel(seriesIsWatched: $seriesIsWatched, loadstate: $loadstate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeriesNavigationModelImpl &&
            (identical(other.seriesIsWatched, seriesIsWatched) ||
                other.seriesIsWatched == seriesIsWatched) &&
            (identical(other.loadstate, loadstate) ||
                other.loadstate == loadstate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seriesIsWatched, loadstate);

  /// Create a copy of SeriesNavigationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeriesNavigationModelImplCopyWith<_$SeriesNavigationModelImpl>
      get copyWith => __$$SeriesNavigationModelImplCopyWithImpl<
          _$SeriesNavigationModelImpl>(this, _$identity);
}

abstract class _SeriesNavigationModel implements SeriesNavigationModel {
  const factory _SeriesNavigationModel(
      {required final bool seriesIsWatched,
      required final LoadState loadstate}) = _$SeriesNavigationModelImpl;

  @override
  bool get seriesIsWatched;
  @override
  LoadState get loadstate;

  /// Create a copy of SeriesNavigationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeriesNavigationModelImplCopyWith<_$SeriesNavigationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
