// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_verification_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OtpVerificationFormState {
  IssueOtpState get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  AppError<dynamic>? get error => throw _privateConstructorUsedError;
  String get phoneNo => throw _privateConstructorUsedError;
  String get otpCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OtpVerificationFormStateCopyWith<OtpVerificationFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerificationFormStateCopyWith<$Res> {
  factory $OtpVerificationFormStateCopyWith(OtpVerificationFormState value,
          $Res Function(OtpVerificationFormState) then) =
      _$OtpVerificationFormStateCopyWithImpl<$Res, OtpVerificationFormState>;
  @useResult
  $Res call(
      {IssueOtpState status,
      String? message,
      AppError<dynamic>? error,
      String phoneNo,
      String otpCode});
}

/// @nodoc
class _$OtpVerificationFormStateCopyWithImpl<$Res,
        $Val extends OtpVerificationFormState>
    implements $OtpVerificationFormStateCopyWith<$Res> {
  _$OtpVerificationFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? error = freezed,
    Object? phoneNo = null,
    Object? otpCode = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as IssueOtpState,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppError<dynamic>?,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String,
      otpCode: null == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpVerificationFormStateImplCopyWith<$Res>
    implements $OtpVerificationFormStateCopyWith<$Res> {
  factory _$$OtpVerificationFormStateImplCopyWith(
          _$OtpVerificationFormStateImpl value,
          $Res Function(_$OtpVerificationFormStateImpl) then) =
      __$$OtpVerificationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IssueOtpState status,
      String? message,
      AppError<dynamic>? error,
      String phoneNo,
      String otpCode});
}

/// @nodoc
class __$$OtpVerificationFormStateImplCopyWithImpl<$Res>
    extends _$OtpVerificationFormStateCopyWithImpl<$Res,
        _$OtpVerificationFormStateImpl>
    implements _$$OtpVerificationFormStateImplCopyWith<$Res> {
  __$$OtpVerificationFormStateImplCopyWithImpl(
      _$OtpVerificationFormStateImpl _value,
      $Res Function(_$OtpVerificationFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? error = freezed,
    Object? phoneNo = null,
    Object? otpCode = null,
  }) {
    return _then(_$OtpVerificationFormStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as IssueOtpState,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppError<dynamic>?,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String,
      otpCode: null == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpVerificationFormStateImpl extends _OtpVerificationFormState {
  const _$OtpVerificationFormStateImpl(
      {this.status = IssueOtpState.loaded,
      this.message,
      this.error,
      this.phoneNo = '',
      this.otpCode = ''})
      : super._();

  @override
  @JsonKey()
  final IssueOtpState status;
  @override
  final String? message;
  @override
  final AppError<dynamic>? error;
  @override
  @JsonKey()
  final String phoneNo;
  @override
  @JsonKey()
  final String otpCode;

  @override
  String toString() {
    return 'OtpVerificationFormState(status: $status, message: $message, error: $error, phoneNo: $phoneNo, otpCode: $otpCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerificationFormStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.otpCode, otpCode) || other.otpCode == otpCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, message, error, phoneNo, otpCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerificationFormStateImplCopyWith<_$OtpVerificationFormStateImpl>
      get copyWith => __$$OtpVerificationFormStateImplCopyWithImpl<
          _$OtpVerificationFormStateImpl>(this, _$identity);
}

abstract class _OtpVerificationFormState extends OtpVerificationFormState {
  const factory _OtpVerificationFormState(
      {final IssueOtpState status,
      final String? message,
      final AppError<dynamic>? error,
      final String phoneNo,
      final String otpCode}) = _$OtpVerificationFormStateImpl;
  const _OtpVerificationFormState._() : super._();

  @override
  IssueOtpState get status;
  @override
  String? get message;
  @override
  AppError<dynamic>? get error;
  @override
  String get phoneNo;
  @override
  String get otpCode;
  @override
  @JsonKey(ignore: true)
  _$$OtpVerificationFormStateImplCopyWith<_$OtpVerificationFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
