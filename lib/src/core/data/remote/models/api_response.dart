import 'package:freezed_annotation/freezed_annotation.dart';

export 'requests/requests.dart';
export 'responses/responses.dart';
part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final T data;
  final String? message;
  final String? messages;

  ApiResponse(this.data, {this.message, this.messages});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

@JsonSerializable()
class MessageResponse {
  final String? messages;
  final String? message;

  MessageResponse(this.messages, this.message);

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
}
