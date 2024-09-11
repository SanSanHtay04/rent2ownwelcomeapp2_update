// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_submit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginSubmitState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String data) success,
    required TResult Function(String message, AppError<dynamic>? error) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String data)? success,
    TResult? Function(String message, AppError<dynamic>? error)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String data)? success,
    TResult Function(String message, AppError<dynamic>? error)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginSubmitStateIdle value) idle,
    required TResult Function(LoginSubmitStateLoading value) loading,
    required TResult Function(LoginSubmitStateSuccess value) success,
    required TResult Function(LoginSubmitStateFailed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginSubmitStateIdle value)? idle,
    TResult? Function(LoginSubmitStateLoading value)? loading,
    TResult? Function(LoginSubmitStateSuccess value)? success,
    TResult? Function(LoginSubmitStateFailed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginSubmitStateIdle value)? idle,
    TResult Function(LoginSubmitStateLoading value)? loading,
    TResult Function(LoginSubmitStateSuccess value)? success,
    TResult Function(LoginSubmitStateFailed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginSubmitStateCopyWith<$Res> {
  factory $LoginSubmitStateCopyWith(
          LoginSubmitState value, $Res Function(LoginSubmitState) then) =
      _$LoginSubmitStateCopyWithImpl<$Res, LoginSubmitState>;
}

/// @nodoc
class _$LoginSubmitStateCopyWithImpl<$Res, $Val extends LoginSubmitState>
    implements $LoginSubmitStateCopyWith<$Res> {
  _$LoginSubmitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoginSubmitStateIdleImplCopyWith<$Res> {
  factory _$$LoginSubmitStateIdleImplCopyWith(_$LoginSubmitStateIdleImpl value,
          $Res Function(_$LoginSubmitStateIdleImpl) then) =
      __$$LoginSubmitStateIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSubmitStateIdleImplCopyWithImpl<$Res>
    extends _$LoginSubmitStateCopyWithImpl<$Res, _$LoginSubmitStateIdleImpl>
    implements _$$LoginSubmitStateIdleImplCopyWith<$Res> {
  __$$LoginSubmitStateIdleImplCopyWithImpl(_$LoginSubmitStateIdleImpl _value,
      $Res Function(_$LoginSubmitStateIdleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoginSubmitStateIdleImpl implements LoginSubmitStateIdle {
  const _$LoginSubmitStateIdleImpl();

  @override
  String toString() {
    return 'LoginSubmitState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginSubmitStateIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String data) success,
    required TResult Function(String message, AppError<dynamic>? error) failed,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String data)? success,
    TResult? Function(String message, AppError<dynamic>? error)? failed,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String data)? success,
    TResult Function(String message, AppError<dynamic>? error)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginSubmitStateIdle value) idle,
    required TResult Function(LoginSubmitStateLoading value) loading,
    required TResult Function(LoginSubmitStateSuccess value) success,
    required TResult Function(LoginSubmitStateFailed value) failed,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginSubmitStateIdle value)? idle,
    TResult? Function(LoginSubmitStateLoading value)? loading,
    TResult? Function(LoginSubmitStateSuccess value)? success,
    TResult? Function(LoginSubmitStateFailed value)? failed,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginSubmitStateIdle value)? idle,
    TResult Function(LoginSubmitStateLoading value)? loading,
    TResult Function(LoginSubmitStateSuccess value)? success,
    TResult Function(LoginSubmitStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class LoginSubmitStateIdle implements LoginSubmitState {
  const factory LoginSubmitStateIdle() = _$LoginSubmitStateIdleImpl;
}

/// @nodoc
abstract class _$$LoginSubmitStateLoadingImplCopyWith<$Res> {
  factory _$$LoginSubmitStateLoadingImplCopyWith(
          _$LoginSubmitStateLoadingImpl value,
          $Res Function(_$LoginSubmitStateLoadingImpl) then) =
      __$$LoginSubmitStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSubmitStateLoadingImplCopyWithImpl<$Res>
    extends _$LoginSubmitStateCopyWithImpl<$Res, _$LoginSubmitStateLoadingImpl>
    implements _$$LoginSubmitStateLoadingImplCopyWith<$Res> {
  __$$LoginSubmitStateLoadingImplCopyWithImpl(
      _$LoginSubmitStateLoadingImpl _value,
      $Res Function(_$LoginSubmitStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoginSubmitStateLoadingImpl implements LoginSubmitStateLoading {
  const _$LoginSubmitStateLoadingImpl();

  @override
  String toString() {
    return 'LoginSubmitState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginSubmitStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String data) success,
    required TResult Function(String message, AppError<dynamic>? error) failed,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String data)? success,
    TResult? Function(String message, AppError<dynamic>? error)? failed,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String data)? success,
    TResult Function(String message, AppError<dynamic>? error)? failed,
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
    required TResult Function(LoginSubmitStateIdle value) idle,
    required TResult Function(LoginSubmitStateLoading value) loading,
    required TResult Function(LoginSubmitStateSuccess value) success,
    required TResult Function(LoginSubmitStateFailed value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginSubmitStateIdle value)? idle,
    TResult? Function(LoginSubmitStateLoading value)? loading,
    TResult? Function(LoginSubmitStateSuccess value)? success,
    TResult? Function(LoginSubmitStateFailed value)? failed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginSubmitStateIdle value)? idle,
    TResult Function(LoginSubmitStateLoading value)? loading,
    TResult Function(LoginSubmitStateSuccess value)? success,
    TResult Function(LoginSubmitStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoginSubmitStateLoading implements LoginSubmitState {
  const factory LoginSubmitStateLoading() = _$LoginSubmitStateLoadingImpl;
}

/// @nodoc
abstract class _$$LoginSubmitStateSuccessImplCopyWith<$Res> {
  factory _$$LoginSubmitStateSuccessImplCopyWith(
          _$LoginSubmitStateSuccessImpl value,
          $Res Function(_$LoginSubmitStateSuccessImpl) then) =
      __$$LoginSubmitStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String data});
}

/// @nodoc
class __$$LoginSubmitStateSuccessImplCopyWithImpl<$Res>
    extends _$LoginSubmitStateCopyWithImpl<$Res, _$LoginSubmitStateSuccessImpl>
    implements _$$LoginSubmitStateSuccessImplCopyWith<$Res> {
  __$$LoginSubmitStateSuccessImplCopyWithImpl(
      _$LoginSubmitStateSuccessImpl _value,
      $Res Function(_$LoginSubmitStateSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$LoginSubmitStateSuccessImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginSubmitStateSuccessImpl implements LoginSubmitStateSuccess {
  const _$LoginSubmitStateSuccessImpl(this.data);

  @override
  final String data;

  @override
  String toString() {
    return 'LoginSubmitState.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginSubmitStateSuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginSubmitStateSuccessImplCopyWith<_$LoginSubmitStateSuccessImpl>
      get copyWith => __$$LoginSubmitStateSuccessImplCopyWithImpl<
          _$LoginSubmitStateSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String data) success,
    required TResult Function(String message, AppError<dynamic>? error) failed,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String data)? success,
    TResult? Function(String message, AppError<dynamic>? error)? failed,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String data)? success,
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
    required TResult Function(LoginSubmitStateIdle value) idle,
    required TResult Function(LoginSubmitStateLoading value) loading,
    required TResult Function(LoginSubmitStateSuccess value) success,
    required TResult Function(LoginSubmitStateFailed value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginSubmitStateIdle value)? idle,
    TResult? Function(LoginSubmitStateLoading value)? loading,
    TResult? Function(LoginSubmitStateSuccess value)? success,
    TResult? Function(LoginSubmitStateFailed value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginSubmitStateIdle value)? idle,
    TResult Function(LoginSubmitStateLoading value)? loading,
    TResult Function(LoginSubmitStateSuccess value)? success,
    TResult Function(LoginSubmitStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class LoginSubmitStateSuccess implements LoginSubmitState {
  const factory LoginSubmitStateSuccess(final String data) =
      _$LoginSubmitStateSuccessImpl;

  String get data;
  @JsonKey(ignore: true)
  _$$LoginSubmitStateSuccessImplCopyWith<_$LoginSubmitStateSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginSubmitStateFailedImplCopyWith<$Res> {
  factory _$$LoginSubmitStateFailedImplCopyWith(
          _$LoginSubmitStateFailedImpl value,
          $Res Function(_$LoginSubmitStateFailedImpl) then) =
      __$$LoginSubmitStateFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, AppError<dynamic>? error});
}

/// @nodoc
class __$$LoginSubmitStateFailedImplCopyWithImpl<$Res>
    extends _$LoginSubmitStateCopyWithImpl<$Res, _$LoginSubmitStateFailedImpl>
    implements _$$LoginSubmitStateFailedImplCopyWith<$Res> {
  __$$LoginSubmitStateFailedImplCopyWithImpl(
      _$LoginSubmitStateFailedImpl _value,
      $Res Function(_$LoginSubmitStateFailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? error = freezed,
  }) {
    return _then(_$LoginSubmitStateFailedImpl(
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

class _$LoginSubmitStateFailedImpl implements LoginSubmitStateFailed {
  const _$LoginSubmitStateFailedImpl(this.message, {this.error});

  @override
  final String message;
  @override
  final AppError<dynamic>? error;

  @override
  String toString() {
    return 'LoginSubmitState.failed(message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginSubmitStateFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginSubmitStateFailedImplCopyWith<_$LoginSubmitStateFailedImpl>
      get copyWith => __$$LoginSubmitStateFailedImplCopyWithImpl<
          _$LoginSubmitStateFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String data) success,
    required TResult Function(String message, AppError<dynamic>? error) failed,
  }) {
    return failed(message, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String data)? success,
    TResult? Function(String message, AppError<dynamic>? error)? failed,
  }) {
    return failed?.call(message, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String data)? success,
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
    required TResult Function(LoginSubmitStateIdle value) idle,
    required TResult Function(LoginSubmitStateLoading value) loading,
    required TResult Function(LoginSubmitStateSuccess value) success,
    required TResult Function(LoginSubmitStateFailed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginSubmitStateIdle value)? idle,
    TResult? Function(LoginSubmitStateLoading value)? loading,
    TResult? Function(LoginSubmitStateSuccess value)? success,
    TResult? Function(LoginSubmitStateFailed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginSubmitStateIdle value)? idle,
    TResult Function(LoginSubmitStateLoading value)? loading,
    TResult Function(LoginSubmitStateSuccess value)? success,
    TResult Function(LoginSubmitStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class LoginSubmitStateFailed implements LoginSubmitState {
  const factory LoginSubmitStateFailed(final String message,
      {final AppError<dynamic>? error}) = _$LoginSubmitStateFailedImpl;

  String get message;
  AppError<dynamic>? get error;
  @JsonKey(ignore: true)
  _$$LoginSubmitStateFailedImplCopyWith<_$LoginSubmitStateFailedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
