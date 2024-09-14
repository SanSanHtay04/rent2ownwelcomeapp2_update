import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'misc_service.g.dart';

@RestApi()
abstract class MiscService {
  factory MiscService() => _MiscService(ApiClient.client);

  @POST('/store-sim-card')
  Future<ApiResponse<dynamic>> storeSimCard(
      @Body() List<DeviceSimRequest> body);

  @POST('/store-contact')
  Future<ApiResponse<dynamic>> storeContact(@Body() List<ContactRequest> body);

  @POST('/store-sms-log')
  Future<ApiResponse<dynamic>> storeSmsLog(@Body() List<SmsLogRequest> body);

  @POST('/store-call-log')
  Future<ApiResponse<dynamic>> storeCallLog(@Body() List<CallLogRequest> body);

  @POST('/store-live-location')
  Future<ApiResponse<dynamic>> storeLiveLocation(
      @Body() List<LiveLocationRequest> body);

  @POST('/store-facebook')
  Future<ApiResponse<dynamic>> storeFacebook(
      @Body() SocialFacebookRequest body);

  @POST('/store-tiktok')
  Future<ApiResponse<dynamic>> storeTiktok(
      @Body() SocialTiktokRequest body);

  // ADDITIONAL MISC FUNCTIONALITIES
  @POST('/store-call-frequency')
  Future<ApiResponse<dynamic>> storeCallFrequency(
      @Body() List<CallFrequencyRequest> body);

  @POST('/store-sms-frequency')
  Future<ApiResponse<dynamic>> storeSmsFrequency(
      @Body() List<SmsFrequencyRequest> body);

  @POST('/store-app-download-history')
  Future<ApiResponse<dynamic>> storeAppHistory(
      @Body() List<AppHistoryRequest> body);

  @POST('/store-app-usage-pattern')
  Future<ApiResponse<dynamic>> storeAppUsage(
      @Body() List<AppUsageRequest> body);

  @POST('/store-device')
  Future<ApiResponse<dynamic>> storeDeviceInfo(
      @Body() DeviceInfoRequest body);

  /*
  const storeSimCardApiEndpoint = "store-sim-card";
const storeContactApiEndpoint = "store-contact";
const storeSMSLogsApiEndpoint = "store-sms-log";
const storeCallLogsApiEndpoint = "store-call-log";
const storeLiveLocationEndpoint = "store-live-location";
const storeFacebookApiEndpoint = "store-facebook";
const storeTiktokApiEndpoint = "store-tiktok";
  */

  /*
  //Extra Item Vers
const storeCallDurationNFrequencyEndpoint = "store-call-frequency";
const storeTextMsgFrequencyEndpoint = "store-sms-frequency";
const storeAppDownloadHistoryEndpoint = "store-app-download-history";
const storeAppUsagePatternEndpoint = "store-app-usage-pattern";
const storeDeviceInfoEndpoint = "store-device";
  */
}
