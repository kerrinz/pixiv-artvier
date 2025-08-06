// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_viewer_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NovelViewerSettingsModel {
  double get textSize => throw _privateConstructorUsedError;

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelViewerSettingsModelCopyWith<NovelViewerSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelViewerSettingsModelCopyWith<$Res> {
  factory $NovelViewerSettingsModelCopyWith(NovelViewerSettingsModel value,
          $Res Function(NovelViewerSettingsModel) then) =
      _$NovelViewerSettingsModelCopyWithImpl<$Res, NovelViewerSettingsModel>;
  @useResult
  $Res call({double textSize});
}

/// @nodoc
class _$NovelViewerSettingsModelCopyWithImpl<$Res,
        $Val extends NovelViewerSettingsModel>
    implements $NovelViewerSettingsModelCopyWith<$Res> {
  _$NovelViewerSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textSize = null,
  }) {
    return _then(_value.copyWith(
      textSize: null == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovelViewerSettingsModelImplCopyWith<$Res>
    implements $NovelViewerSettingsModelCopyWith<$Res> {
  factory _$$NovelViewerSettingsModelImplCopyWith(
          _$NovelViewerSettingsModelImpl value,
          $Res Function(_$NovelViewerSettingsModelImpl) then) =
      __$$NovelViewerSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double textSize});
}

/// @nodoc
class __$$NovelViewerSettingsModelImplCopyWithImpl<$Res>
    extends _$NovelViewerSettingsModelCopyWithImpl<$Res,
        _$NovelViewerSettingsModelImpl>
    implements _$$NovelViewerSettingsModelImplCopyWith<$Res> {
  __$$NovelViewerSettingsModelImplCopyWithImpl(
      _$NovelViewerSettingsModelImpl _value,
      $Res Function(_$NovelViewerSettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textSize = null,
  }) {
    return _then(_$NovelViewerSettingsModelImpl(
      textSize: null == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$NovelViewerSettingsModelImpl implements _NovelViewerSettingsModel {
  const _$NovelViewerSettingsModelImpl({required this.textSize});

  @override
  final double textSize;

  @override
  String toString() {
    return 'NovelViewerSettingsModel(textSize: $textSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelViewerSettingsModelImpl &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, textSize);

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelViewerSettingsModelImplCopyWith<_$NovelViewerSettingsModelImpl>
      get copyWith => __$$NovelViewerSettingsModelImplCopyWithImpl<
          _$NovelViewerSettingsModelImpl>(this, _$identity);
}

abstract class _NovelViewerSettingsModel implements NovelViewerSettingsModel {
  const factory _NovelViewerSettingsModel({required final double textSize}) =
      _$NovelViewerSettingsModelImpl;

  @override
  double get textSize;

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelViewerSettingsModelImplCopyWith<_$NovelViewerSettingsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
