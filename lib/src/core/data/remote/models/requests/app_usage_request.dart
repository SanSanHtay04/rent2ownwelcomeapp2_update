
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_usage_request.freezed.dart';
part 'app_usage_request.g.dart';

@freezed
class AppUsageRequest with _$AppUsageRequest {
  const AppUsageRequest._();

  const factory AppUsageRequest(
      {required String appName,
      required String duration,
      required String timeFrom,
      required String timeTo,
    }) = _AppUsageRequest;

  factory AppUsageRequest.fromJson(Map<String, dynamic> json) =>
      _$AppUsageRequestFromJson(json);
}

/*
  {
        'appName': appName,
        'duration': duration,
        'timeFrom': timeFrom,
        'timeTo': timeTo
      };
*/
