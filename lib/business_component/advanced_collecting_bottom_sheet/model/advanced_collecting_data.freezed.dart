// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advanced_collecting_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdvancedCollectingDataModel {
  List<WorksCollectTag> get tags => throw _privateConstructorUsedError;
  Restrict get restrict => throw _privateConstructorUsedError;
  CollectState get collectState => throw _privateConstructorUsedError;

  /// Create a copy of AdvancedCollectingDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdvancedCollectingDataModelCopyWith<AdvancedCollectingDataModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvancedCollectingDataModelCopyWith<$Res> {
  factory $AdvancedCollectingDataModelCopyWith(
          AdvancedCollectingDataModel value,
          $Res Function(AdvancedCollectingDataModel) then) =
      _$AdvancedCollectingDataModelCopyWithImpl<$Res,
          AdvancedCollectingDataModel>;
  @useResult
  $Res call(
      {List<WorksCollectTag> tags,
      Restrict restrict,
      CollectState collectState});
}

/// @nodoc
class _$AdvancedCollectingDataModelCopyWithImpl<$Res,
        $Val extends AdvancedCollectingDataModel>
    implements $AdvancedCollectingDataModelCopyWith<$Res> {
  _$AdvancedCollectingDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdvancedCollectingDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
    Object? restrict = null,
    Object? collectState = null,
  }) {
    return _then(_value.copyWith(
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<WorksCollectTag>,
      restrict: null == restrict
          ? _value.restrict
          : restrict // ignore: cast_nullable_to_non_nullable
              as Restrict,
      collectState: null == collectState
          ? _value.collectState
          : collectState // ignore: cast_nullable_to_non_nullable
              as CollectState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdvancedCollectingDataModelImplCopyWith<$Res>
    implements $AdvancedCollectingDataModelCopyWith<$Res> {
  factory _$$AdvancedCollectingDataModelImplCopyWith(
          _$AdvancedCollectingDataModelImpl value,
          $Res Function(_$AdvancedCollectingDataModelImpl) then) =
      __$$AdvancedCollectingDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<WorksCollectTag> tags,
      Restrict restrict,
      CollectState collectState});
}

/// @nodoc
class __$$AdvancedCollectingDataModelImplCopyWithImpl<$Res>
    extends _$AdvancedCollectingDataModelCopyWithImpl<$Res,
        _$AdvancedCollectingDataModelImpl>
    implements _$$AdvancedCollectingDataModelImplCopyWith<$Res> {
  __$$AdvancedCollectingDataModelImplCopyWithImpl(
      _$AdvancedCollectingDataModelImpl _value,
      $Res Function(_$AdvancedCollectingDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdvancedCollectingDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
    Object? restrict = null,
    Object? collectState = null,
  }) {
    return _then(_$AdvancedCollectingDataModelImpl(
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<WorksCollectTag>,
      restrict: null == restrict
          ? _value.restrict
          : restrict // ignore: cast_nullable_to_non_nullable
              as Restrict,
      collectState: null == collectState
          ? _value.collectState
          : collectState // ignore: cast_nullable_to_non_nullable
              as CollectState,
    ));
  }
}

/// @nodoc

class _$AdvancedCollectingDataModelImpl
    implements _AdvancedCollectingDataModel {
  _$AdvancedCollectingDataModelImpl(
      {required final List<WorksCollectTag> tags,
      required this.restrict,
      required this.collectState})
      : _tags = tags;

  final List<WorksCollectTag> _tags;
  @override
  List<WorksCollectTag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final Restrict restrict;
  @override
  final CollectState collectState;

  @override
  String toString() {
    return 'AdvancedCollectingDataModel(tags: $tags, restrict: $restrict, collectState: $collectState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdvancedCollectingDataModelImpl &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.restrict, restrict) ||
                other.restrict == restrict) &&
            (identical(other.collectState, collectState) ||
                other.collectState == collectState));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_tags), restrict, collectState);

  /// Create a copy of AdvancedCollectingDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdvancedCollectingDataModelImplCopyWith<_$AdvancedCollectingDataModelImpl>
      get copyWith => __$$AdvancedCollectingDataModelImplCopyWithImpl<
          _$AdvancedCollectingDataModelImpl>(this, _$identity);
}

abstract class _AdvancedCollectingDataModel
    implements AdvancedCollectingDataModel {
  factory _AdvancedCollectingDataModel(
          {required final List<WorksCollectTag> tags,
          required final Restrict restrict,
          required final CollectState collectState}) =
      _$AdvancedCollectingDataModelImpl;

  @override
  List<WorksCollectTag> get tags;
  @override
  Restrict get restrict;
  @override
  CollectState get collectState;

  /// Create a copy of AdvancedCollectingDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdvancedCollectingDataModelImplCopyWith<_$AdvancedCollectingDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
