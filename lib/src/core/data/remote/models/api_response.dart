import 'package:freezed_annotation/freezed_annotation.dart';
export 'requests/requests.dart';
export 'responses/responses.dart';

part 'api_response.g.dart';

// @freezed
// class ApiResonse with _$ApiResonse {
//   const ApiResonse._();

//   const factory ApiResonse({
//      @JsonKey(name: 'status_code')  String? code,
//      @JsonKey(name: 'status_message') String? message,
//   }) = _ApiResonse;

//   factory ApiResonse.fromJson(Map<String, dynamic> json) =>
//       _$ApiResonseFromJson(json);
// }

// {
//     "status_code": "SUCCESS",
//     "status_message": "Successfully stored contact list for device imei no testing"
// }

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final T data;
  final String? code;
  final String? message;
  final String? messages;

  ApiResponse(
    this.data, {
    this.code,
    this.message,
    this.messages,
  });

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

// @JsonSerializable()
// class MessageResponse {
//   final String? messages;
//   final String? message;

//   MessageResponse(this.messages, this.message);

//   factory MessageResponse.fromJson(Map<String, dynamic> json) =>
//       _$MessageResponseFromJson(json);
// }
