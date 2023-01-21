// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collections_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CollectionsState<Data> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(Data data) data,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Data data)? data,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Data data)? data,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<Data> value) loading,
    required TResult Function(_Empty<Data> value) empty,
    required TResult Function(_Data<Data> value) data,
    required TResult Function(_Error<Data> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<Data> value)? loading,
    TResult? Function(_Empty<Data> value)? empty,
    TResult? Function(_Data<Data> value)? data,
    TResult? Function(_Error<Data> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<Data> value)? loading,
    TResult Function(_Empty<Data> value)? empty,
    TResult Function(_Data<Data> value)? data,
    TResult Function(_Error<Data> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionsStateCopyWith<Data, $Res> {
  factory $CollectionsStateCopyWith(CollectionsState<Data> value,
          $Res Function(CollectionsState<Data>) then) =
      _$CollectionsStateCopyWithImpl<Data, $Res, CollectionsState<Data>>;
}

/// @nodoc
class _$CollectionsStateCopyWithImpl<Data, $Res,
        $Val extends CollectionsState<Data>>
    implements $CollectionsStateCopyWith<Data, $Res> {
  _$CollectionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<Data, $Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading<Data> value, $Res Function(_$_Loading<Data>) then) =
      __$$_LoadingCopyWithImpl<Data, $Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<Data, $Res>
    extends _$CollectionsStateCopyWithImpl<Data, $Res, _$_Loading<Data>>
    implements _$$_LoadingCopyWith<Data, $Res> {
  __$$_LoadingCopyWithImpl(
      _$_Loading<Data> _value, $Res Function(_$_Loading<Data>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading<Data> implements _Loading<Data> {
  const _$_Loading();

  @override
  String toString() {
    return 'CollectionsState<$Data>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading<Data>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(Data data) data,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Data data)? data,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Data data)? data,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<Data> value) loading,
    required TResult Function(_Empty<Data> value) empty,
    required TResult Function(_Data<Data> value) data,
    required TResult Function(_Error<Data> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<Data> value)? loading,
    TResult? Function(_Empty<Data> value)? empty,
    TResult? Function(_Data<Data> value)? data,
    TResult? Function(_Error<Data> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<Data> value)? loading,
    TResult Function(_Empty<Data> value)? empty,
    TResult Function(_Data<Data> value)? data,
    TResult Function(_Error<Data> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading<Data> implements CollectionsState<Data> {
  const factory _Loading() = _$_Loading<Data>;
}

/// @nodoc
abstract class _$$_EmptyCopyWith<Data, $Res> {
  factory _$$_EmptyCopyWith(
          _$_Empty<Data> value, $Res Function(_$_Empty<Data>) then) =
      __$$_EmptyCopyWithImpl<Data, $Res>;
}

/// @nodoc
class __$$_EmptyCopyWithImpl<Data, $Res>
    extends _$CollectionsStateCopyWithImpl<Data, $Res, _$_Empty<Data>>
    implements _$$_EmptyCopyWith<Data, $Res> {
  __$$_EmptyCopyWithImpl(
      _$_Empty<Data> _value, $Res Function(_$_Empty<Data>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Empty<Data> implements _Empty<Data> {
  const _$_Empty();

  @override
  String toString() {
    return 'CollectionsState<$Data>.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Empty<Data>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(Data data) data,
    required TResult Function(String error) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Data data)? data,
    TResult? Function(String error)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Data data)? data,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<Data> value) loading,
    required TResult Function(_Empty<Data> value) empty,
    required TResult Function(_Data<Data> value) data,
    required TResult Function(_Error<Data> value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<Data> value)? loading,
    TResult? Function(_Empty<Data> value)? empty,
    TResult? Function(_Data<Data> value)? data,
    TResult? Function(_Error<Data> value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<Data> value)? loading,
    TResult Function(_Empty<Data> value)? empty,
    TResult Function(_Data<Data> value)? data,
    TResult Function(_Error<Data> value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty<Data> implements CollectionsState<Data> {
  const factory _Empty() = _$_Empty<Data>;
}

/// @nodoc
abstract class _$$_DataCopyWith<Data, $Res> {
  factory _$$_DataCopyWith(
          _$_Data<Data> value, $Res Function(_$_Data<Data>) then) =
      __$$_DataCopyWithImpl<Data, $Res>;
  @useResult
  $Res call({Data data});
}

/// @nodoc
class __$$_DataCopyWithImpl<Data, $Res>
    extends _$CollectionsStateCopyWithImpl<Data, $Res, _$_Data<Data>>
    implements _$$_DataCopyWith<Data, $Res> {
  __$$_DataCopyWithImpl(
      _$_Data<Data> _value, $Res Function(_$_Data<Data>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_Data<Data>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data,
    ));
  }
}

/// @nodoc

class _$_Data<Data> implements _Data<Data> {
  const _$_Data(this.data);

  @override
  final Data data;

  @override
  String toString() {
    return 'CollectionsState<$Data>.data(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data<Data> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataCopyWith<Data, _$_Data<Data>> get copyWith =>
      __$$_DataCopyWithImpl<Data, _$_Data<Data>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(Data data) data,
    required TResult Function(String error) error,
  }) {
    return data(this.data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Data data)? data,
    TResult? Function(String error)? error,
  }) {
    return data?.call(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Data data)? data,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<Data> value) loading,
    required TResult Function(_Empty<Data> value) empty,
    required TResult Function(_Data<Data> value) data,
    required TResult Function(_Error<Data> value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<Data> value)? loading,
    TResult? Function(_Empty<Data> value)? empty,
    TResult? Function(_Data<Data> value)? data,
    TResult? Function(_Error<Data> value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<Data> value)? loading,
    TResult Function(_Empty<Data> value)? empty,
    TResult Function(_Data<Data> value)? data,
    TResult Function(_Error<Data> value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Data<Data> implements CollectionsState<Data> {
  const factory _Data(final Data data) = _$_Data<Data>;

  Data get data;
  @JsonKey(ignore: true)
  _$$_DataCopyWith<Data, _$_Data<Data>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<Data, $Res> {
  factory _$$_ErrorCopyWith(
          _$_Error<Data> value, $Res Function(_$_Error<Data>) then) =
      __$$_ErrorCopyWithImpl<Data, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<Data, $Res>
    extends _$CollectionsStateCopyWithImpl<Data, $Res, _$_Error<Data>>
    implements _$$_ErrorCopyWith<Data, $Res> {
  __$$_ErrorCopyWithImpl(
      _$_Error<Data> _value, $Res Function(_$_Error<Data>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$_Error<Data>(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error<Data> implements _Error<Data> {
  const _$_Error(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'CollectionsState<$Data>.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error<Data> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorCopyWith<Data, _$_Error<Data>> get copyWith =>
      __$$_ErrorCopyWithImpl<Data, _$_Error<Data>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(Data data) data,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Data data)? data,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Data data)? data,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<Data> value) loading,
    required TResult Function(_Empty<Data> value) empty,
    required TResult Function(_Data<Data> value) data,
    required TResult Function(_Error<Data> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<Data> value)? loading,
    TResult? Function(_Empty<Data> value)? empty,
    TResult? Function(_Data<Data> value)? data,
    TResult? Function(_Error<Data> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<Data> value)? loading,
    TResult Function(_Empty<Data> value)? empty,
    TResult Function(_Data<Data> value)? data,
    TResult Function(_Error<Data> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<Data> implements CollectionsState<Data> {
  const factory _Error(final String error) = _$_Error<Data>;

  String get error;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<Data, _$_Error<Data>> get copyWith =>
      throw _privateConstructorUsedError;
}
