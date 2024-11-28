import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_history_request.freezed.dart';
part 'app_history_request.g.dart';

@freezed
class AppHistoryRequest with _$AppHistoryRequest {
  const AppHistoryRequest._();

  const factory AppHistoryRequest({
    required String packageName,
    required String appName,
    required String version,
  }) = _AppHistoryRequest;

  factory AppHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$AppHistoryRequestFromJson(json);
}

/*
  {'packageName': packageName, 
  'appName': appName, 
  'version': version};
*/
