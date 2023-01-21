// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collections_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CollectionsFilterModel {
  /// 隐私
  Restrict get restrict => throw _privateConstructorUsedError;

  /// 根据tag筛选，当null时不根据tag筛选，当值为""即Empty String时，表示”未分類“
  String? get tag => throw _privateConstructorUsedError;

  /// 作品类型
  WorksType get worksType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CollectionsFilterModelCopyWith<CollectionsFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionsFilterModelCopyWith<$Res> {
  factory $CollectionsFilterModelCopyWith(CollectionsFilterModel value,
          $Res Function(CollectionsFilterModel) then) =
      _$CollectionsFilterModelCopyWithImpl<$Res, CollectionsFilterModel>;
  @useResult
  $Res call({Restrict restrict, String? tag, WorksType worksType});
}

/// @nodoc
class _$CollectionsFilterModelCopyWithImpl<$Res,
        $Val extends CollectionsFilterModel>
    implements $CollectionsFilterModelCopyWith<$Res> {
  _$CollectionsFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restrict = null,
    Object? tag = freezed,
    Object? worksType = null,
  }) {
    return _then(_value.copyWith(
      restrict: null == restrict
          ? _value.restrict
          : restrict // ignore: cast_nullable_to_non_nullable
              as Restrict,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      worksType: null == worksType
          ? _value.worksType
          : worksType // ignore: cast_nullable_to_non_nullable
              as WorksType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CollectionsFilterModelCopyWith<$Res>
    implements $CollectionsFilterModelCopyWith<$Res> {
  factory _$$_CollectionsFilterModelCopyWith(_$_CollectionsFilterModel value,
          $Res Function(_$_CollectionsFilterModel) then) =
      __$$_CollectionsFilterModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Restrict restrict, String? tag, WorksType worksType});
}

/// @nodoc
class __$$_CollectionsFilterModelCopyWithImpl<$Res>
    extends _$CollectionsFilterModelCopyWithImpl<$Res,
        _$_CollectionsFilterModel>
    implements _$$_CollectionsFilterModelCopyWith<$Res> {
  __$$_CollectionsFilterModelCopyWithImpl(_$_CollectionsFilterModel _value,
      $Res Function(_$_CollectionsFilterModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restrict = null,
    Object? tag = freezed,
    Object? worksType = null,
  }) {
    return _then(_$_CollectionsFilterModel(
      restrict: null == restrict
          ? _value.restrict
          : restrict // ignore: cast_nullable_to_non_nullable
              as Restrict,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      worksType: null == worksType
          ? _value.worksType
          : worksType // ignore: cast_nullable_to_non_nullable
              as WorksType,
    ));
  }
}

/// @nodoc

class _$_CollectionsFilterModel implements _CollectionsFilterModel {
  const _$_CollectionsFilterModel(
      {this.restrict = Restrict.public, this.tag, required this.worksType});

  /// 隐私
  @override
  @JsonKey()
  final Restrict restrict;

  /// 根据tag筛选，当null时不根据tag筛选，当值为""即Empty String时，表示”未分類“
  @override
  final String? tag;

  /// 作品类型
  @override
  final WorksType worksType;

  @override
  String toString() {
    return 'CollectionsFilterModel(restrict: $restrict, tag: $tag, worksType: $worksType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CollectionsFilterModel &&
            (identical(other.restrict, restrict) ||
                other.restrict == restrict) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.worksType, worksType) ||
                other.worksType == worksType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, restrict, tag, worksType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CollectionsFilterModelCopyWith<_$_CollectionsFilterModel> get copyWith =>
      __$$_CollectionsFilterModelCopyWithImpl<_$_CollectionsFilterModel>(
          this, _$identity);
}

abstract class _CollectionsFilterModel implements CollectionsFilterModel {
  const factory _CollectionsFilterModel(
      {final Restrict restrict,
      final String? tag,
      required final WorksType worksType}) = _$_CollectionsFilterModel;

  @override

  /// 隐私
  Restrict get restrict;
  @override

  /// 根据tag筛选，当null时不根据tag筛选，当值为""即Empty String时，表示”未分類“
  String? get tag;
  @override

  /// 作品类型
  WorksType get worksType;
  @override
  @JsonKey(ignore: true)
  _$$_CollectionsFilterModelCopyWith<_$_CollectionsFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}
