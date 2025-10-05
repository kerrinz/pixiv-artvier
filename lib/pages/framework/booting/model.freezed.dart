// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BootingPageArguments {
  /// 跳转下一个页面的路由名
  String get nextRoute => throw _privateConstructorUsedError;

  /// 跳转下一个页面的路由携带参数
  Object? get nextRouteArguments => throw _privateConstructorUsedError;

  /// Create a copy of BootingPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BootingPageArgumentsCopyWith<BootingPageArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BootingPageArgumentsCopyWith<$Res> {
  factory $BootingPageArgumentsCopyWith(BootingPageArguments value,
          $Res Function(BootingPageArguments) then) =
      _$BootingPageArgumentsCopyWithImpl<$Res, BootingPageArguments>;
  @useResult
  $Res call({String nextRoute, Object? nextRouteArguments});
}

/// @nodoc
class _$BootingPageArgumentsCopyWithImpl<$Res,
        $Val extends BootingPageArguments>
    implements $BootingPageArgumentsCopyWith<$Res> {
  _$BootingPageArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BootingPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextRoute = null,
    Object? nextRouteArguments = freezed,
  }) {
    return _then(_value.copyWith(
      nextRoute: null == nextRoute
          ? _value.nextRoute
          : nextRoute // ignore: cast_nullable_to_non_nullable
              as String,
      nextRouteArguments: freezed == nextRouteArguments
          ? _value.nextRouteArguments
          : nextRouteArguments,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BootingPageArgumentsImplCopyWith<$Res>
    implements $BootingPageArgumentsCopyWith<$Res> {
  factory _$$BootingPageArgumentsImplCopyWith(_$BootingPageArgumentsImpl value,
          $Res Function(_$BootingPageArgumentsImpl) then) =
      __$$BootingPageArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nextRoute, Object? nextRouteArguments});
}

/// @nodoc
class __$$BootingPageArgumentsImplCopyWithImpl<$Res>
    extends _$BootingPageArgumentsCopyWithImpl<$Res, _$BootingPageArgumentsImpl>
    implements _$$BootingPageArgumentsImplCopyWith<$Res> {
  __$$BootingPageArgumentsImplCopyWithImpl(_$BootingPageArgumentsImpl _value,
      $Res Function(_$BootingPageArgumentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BootingPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextRoute = null,
    Object? nextRouteArguments = freezed,
  }) {
    return _then(_$BootingPageArgumentsImpl(
      nextRoute: null == nextRoute
          ? _value.nextRoute
          : nextRoute // ignore: cast_nullable_to_non_nullable
              as String,
      nextRouteArguments: freezed == nextRouteArguments
          ? _value.nextRouteArguments
          : nextRouteArguments,
    ));
  }
}

/// @nodoc

class _$BootingPageArgumentsImpl implements _BootingPageArguments {
  const _$BootingPageArgumentsImpl(
      {required this.nextRoute, this.nextRouteArguments});

  /// 跳转下一个页面的路由名
  @override
  final String nextRoute;

  /// 跳转下一个页面的路由携带参数
  @override
  final Object? nextRouteArguments;

  @override
  String toString() {
    return 'BootingPageArguments(nextRoute: $nextRoute, nextRouteArguments: $nextRouteArguments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BootingPageArgumentsImpl &&
            (identical(other.nextRoute, nextRoute) ||
                other.nextRoute == nextRoute) &&
            const DeepCollectionEquality()
                .equals(other.nextRouteArguments, nextRouteArguments));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nextRoute,
      const DeepCollectionEquality().hash(nextRouteArguments));

  /// Create a copy of BootingPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BootingPageArgumentsImplCopyWith<_$BootingPageArgumentsImpl>
      get copyWith =>
          __$$BootingPageArgumentsImplCopyWithImpl<_$BootingPageArgumentsImpl>(
              this, _$identity);
}

abstract class _BootingPageArguments implements BootingPageArguments {
  const factory _BootingPageArguments(
      {required final String nextRoute,
      final Object? nextRouteArguments}) = _$BootingPageArgumentsImpl;

  /// 跳转下一个页面的路由名
  @override
  String get nextRoute;

  /// 跳转下一个页面的路由携带参数
  @override
  Object? get nextRouteArguments;

  /// Create a copy of BootingPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BootingPageArgumentsImplCopyWith<_$BootingPageArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
