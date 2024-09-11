// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_otp_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginOtpResponse _$LoginOtpResponseFromJson(Map<String, dynamic> json) {
  return _LoginOtpResponse.fromJson(json);
}

/// @nodoc
mixin _$LoginOtpResponse {
  @JsonKey(name: 'status_code')
  String? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_message')
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginOtpResponseCopyWith<LoginOtpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginOtpResponseCopyWith<$Res> {
  factory $LoginOtpResponseCopyWith(
          LoginOtpResponse value, $Res Function(LoginOtpResponse) then) =
      _$LoginOtpResponseCopyWithImpl<$Res, LoginOtpResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'status_code') String? code,
      @JsonKey(name: 'status_message') String? message});
}

/// @nodoc
class _$LoginOtpResponseCopyWithImpl<$Res, $Val extends LoginOtpResponse>
    implements $LoginOtpResponseCopyWith<$Res> {
  _$LoginOtpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginOtpResponseImplCopyWith<$Res>
    implements $LoginOtpResponseCopyWith<$Res> {
  factory _$$LoginOtpResponseImplCopyWith(_$LoginOtpResponseImpl value,
          $Res Function(_$LoginOtpResponseImpl) then) =
      __$$LoginOtpResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'status_code') String? code,
      @JsonKey(name: 'status_message') String? message});
}

/// @nodoc
class __$$LoginOtpResponseImplCopyWithImpl<$Res>
    extends _$LoginOtpResponseCopyWithImpl<$Res, _$LoginOtpResponseImpl>
    implements _$$LoginOtpResponseImplCopyWith<$Res> {
  __$$LoginOtpResponseImplCopyWithImpl(_$LoginOtpResponseImpl _value,
      $Res Function(_$LoginOtpResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_$LoginOtpResponseImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginOtpResponseImpl extends _LoginOtpResponse {
  const _$LoginOtpResponseImpl(
      {@JsonKey(name: 'status_code') this.code = '',
      @JsonKey(name: 'status_message') this.message = ''})
      : super._();

  factory _$LoginOtpResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginOtpResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status_code')
  final String? code;
  @override
  @JsonKey(name: 'status_message')
  final String? message;

  @override
  String toString() {
    return 'LoginOtpResponse(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginOtpResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginOtpResponseImplCopyWith<_$LoginOtpResponseImpl> get copyWith =>
      __$$LoginOtpResponseImplCopyWithImpl<_$LoginOtpResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginOtpResponseImplToJson(
      this,
    );
  }
}

abstract class _LoginOtpResponse extends LoginOtpResponse {
  const factory _LoginOtpResponse(
          {@JsonKey(name: 'status_code') final String? code,
          @JsonKey(name: 'status_message') final String? message}) =
      _$LoginOtpResponseImpl;
  const _LoginOtpResponse._() : super._();

  factory _LoginOtpResponse.fromJson(Map<String, dynamic> json) =
      _$LoginOtpResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status_code')
  String? get code;
  @override
  @JsonKey(name: 'status_message')
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$LoginOtpResponseImplCopyWith<_$LoginOtpResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
