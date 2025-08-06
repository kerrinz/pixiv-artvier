// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NovelElementModel {
  /// 小说渲染元素的类型
  NovelElementType get type => throw _privateConstructorUsedError;
  GlobalKey<State<StatefulWidget>>? get key =>
      throw _privateConstructorUsedError;

  /// 小说渲染元素
  dynamic get element => throw _privateConstructorUsedError;

  /// Create a copy of NovelElementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelElementModelCopyWith<NovelElementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelElementModelCopyWith<$Res> {
  factory $NovelElementModelCopyWith(
          NovelElementModel value, $Res Function(NovelElementModel) then) =
      _$NovelElementModelCopyWithImpl<$Res, NovelElementModel>;
  @useResult
  $Res call(
      {NovelElementType type,
      GlobalKey<State<StatefulWidget>>? key,
      dynamic element});
}

/// @nodoc
class _$NovelElementModelCopyWithImpl<$Res, $Val extends NovelElementModel>
    implements $NovelElementModelCopyWith<$Res> {
  _$NovelElementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelElementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? key = freezed,
    Object? element = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NovelElementType,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as GlobalKey<State<StatefulWidget>>?,
      element: freezed == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovelElementModelImplCopyWith<$Res>
    implements $NovelElementModelCopyWith<$Res> {
  factory _$$NovelElementModelImplCopyWith(_$NovelElementModelImpl value,
          $Res Function(_$NovelElementModelImpl) then) =
      __$$NovelElementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NovelElementType type,
      GlobalKey<State<StatefulWidget>>? key,
      dynamic element});
}

/// @nodoc
class __$$NovelElementModelImplCopyWithImpl<$Res>
    extends _$NovelElementModelCopyWithImpl<$Res, _$NovelElementModelImpl>
    implements _$$NovelElementModelImplCopyWith<$Res> {
  __$$NovelElementModelImplCopyWithImpl(_$NovelElementModelImpl _value,
      $Res Function(_$NovelElementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelElementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? key = freezed,
    Object? element = freezed,
  }) {
    return _then(_$NovelElementModelImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NovelElementType,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as GlobalKey<State<StatefulWidget>>?,
      element: freezed == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$NovelElementModelImpl implements _NovelElementModel {
  const _$NovelElementModelImpl(
      {required this.type, this.key, required this.element});

  /// 小说渲染元素的类型
  @override
  final NovelElementType type;
  @override
  final GlobalKey<State<StatefulWidget>>? key;

  /// 小说渲染元素
  @override
  final dynamic element;

  @override
  String toString() {
    return 'NovelElementModel(type: $type, key: $key, element: $element)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelElementModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.key, key) || other.key == key) &&
            const DeepCollectionEquality().equals(other.element, element));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, type, key, const DeepCollectionEquality().hash(element));

  /// Create a copy of NovelElementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelElementModelImplCopyWith<_$NovelElementModelImpl> get copyWith =>
      __$$NovelElementModelImplCopyWithImpl<_$NovelElementModelImpl>(
          this, _$identity);
}

abstract class _NovelElementModel implements NovelElementModel {
  const factory _NovelElementModel(
      {required final NovelElementType type,
      final GlobalKey<State<StatefulWidget>>? key,
      required final dynamic element}) = _$NovelElementModelImpl;

  /// 小说渲染元素的类型
  @override
  NovelElementType get type;
  @override
  GlobalKey<State<StatefulWidget>>? get key;

  /// 小说渲染元素
  @override
  dynamic get element;

  /// Create a copy of NovelElementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelElementModelImplCopyWith<_$NovelElementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
