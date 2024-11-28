import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_location_request.freezed.dart';
part 'live_location_request.g.dart';

@freezed
class LiveLocationRequest with _$LiveLocationRequest {
  const LiveLocationRequest._();

  const factory LiveLocationRequest({
    required  String latitude,
    required String longitude,
  }) = _LiveLocationRequest;

  factory LiveLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$LiveLocationRequestFromJson(json);
}

/*
    {'latitude': latitude, 
    'longitude': longitude};
*/