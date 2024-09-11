// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DataResponse<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message, AppError<dynamic>? error) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message, AppError<dynamic>? error)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message, AppError<dynamic>? error)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessDataResponse<T> value) success,
    required TResult Function(FailedDataResponse<T> value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SuccessDataResponse<T> value)? success,
    TResult? Function(FailedDataResponse<T> value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessDataResponse<T> value)? success,
    TResult Function(FailedDataResponse<T> value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataResponseCopyWith<T, $Res> {
  factory $DataResponseCopyWith(
          DataResponse<T> value, $Res Function(DataResponse<T>) then) =
      _$DataResponseCopyWithImpl<T, $Res, DataResponse<T>>;
}

/// @nodoc
class _$DataResponseCopyWithImpl<T, $Res, $Val extends DataResponse<T>>
    implements $DataResponseCopyWith<T, $Res> {
  _$DataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SuccessDataResponseImplCopyWith<T, $Res> {
  factory _$$SuccessDataResponseImplCopyWith(_$SuccessDataResponseImpl<T> value,
          $Res Function(_$SuccessDataResponseImpl<T>) then) =
      __$$SuccessDataResponseImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$SuccessDataResponseImplCopyWithImpl<T, $Res>
    extends _$DataResponseCopyWithImpl<T, $Res, _$SuccessDataResponseImpl<T>>
    implements _$$SuccessDataResponseImplCopyWith<T, $Res> {
  __$$SuccessDataResponseImplCopyWithImpl(_$SuccessDataResponseImpl<T> _value,
      $Res Function(_$SuccessDataResponseImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SuccessDataResponseImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$SuccessDataResponseImpl<T> extends SuccessDataResponse<T> {
  const _$SuccessDataResponseImpl(this.data) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'DataResponse<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessDataResponseImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessDataResponseImplCopyWith<T, _$SuccessDataResponseImpl<T>>
      get copyWith => __$$SuccessDataResponseImplCopyWithImpl<T,
          _$SuccessDataResponseImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message, AppError<dynamic>? error) failed,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message, AppError<dynamic>? error)? failed,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message, AppError<dynamic>? error)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessDataResponse<T> value) success,
    required TResult Function(FailedDataResponse<T> value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SuccessDataResponse<T> value)? success,
    TResult? Function(FailedDataResponse<T> value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessDataResponse<T> value)? success,
    TResult Function(FailedDataResponse<T> value)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SuccessDataResponse<T> extends DataResponse<T> {
  const factory SuccessDataResponse(final T data) =
      _$SuccessDataResponseImpl<T>;
  const SuccessDataResponse._() : super._();

  T get data;
  @JsonKey(ignore: true)
  _$$SuccessDataResponseImplCopyWith<T, _$SuccessDataResponseImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedDataResponseImplCopyWith<T, $Res> {
  factory _$$FailedDataResponseImplCopyWith(_$FailedDataResponseImpl<T> value,
          $Res Function(_$FailedDataResponseImpl<T>) then) =
      __$$FailedDataResponseImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, AppError<dynamic>? error});
}

/// @nodoc
class __$$FailedDataResponseImplCopyWithImpl<T, $Res>
    extends _$DataResponseCopyWithImpl<T, $Res, _$FailedDataResponseImpl<T>>
    implements _$$FailedDataResponseImplCopyWith<T, $Res> {
  __$$FailedDataResponseImplCopyWithImpl(_$FailedDataResponseImpl<T> _value,
      $Res Function(_$FailedDataResponseImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? error = freezed,
  }) {
    return _then(_$FailedDataResponseImpl<T>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppError<dynamic>?,
    ));
  }
}

/// @nodoc

class _$FailedDataResponseImpl<T> extends FailedDataResponse<T> {
  const _$FailedDataResponseImpl(this.message, {this.error}) : super._();

  @override
  final String message;
  @override
  final AppError<dynamic>? error;

  @override
  String toString() {
    return 'DataResponse<$T>.failed(message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedDataResponseImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedDataResponseImplCopyWith<T, _$FailedDataResponseImpl<T>>
      get copyWith => __$$FailedDataResponseImplCopyWithImpl<T,
          _$FailedDataResponseImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message, AppError<dynamic>? error) failed,
  }) {
    return failed(message, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message, AppError<dynamic>? error)? failed,
  }) {
    return failed?.call(message, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message, AppError<dynamic>? error)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(message, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessDataResponse<T> value) success,
    required TResult Function(FailedDataResponse<T> value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SuccessDataResponse<T> value)? success,
    TResult? Function(FailedDataResponse<T> value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessDataResponse<T> value)? success,
    TResult Function(FailedDataResponse<T> value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class FailedDataResponse<T> extends DataResponse<T> {
  const factory FailedDataResponse(final String message,
      {final AppError<dynamic>? error}) = _$FailedDataResponseImpl<T>;
  const FailedDataResponse._() : super._();

  String get message;
  AppError<dynamic>? get error;
  @JsonKey(ignore: true)
  _$$FailedDataResponseImplCopyWith<T, _$FailedDataResponseImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}
