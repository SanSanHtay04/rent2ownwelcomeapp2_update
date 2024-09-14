import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'common_service.g.dart';

@RestApi()
abstract class CommonService {
  factory CommonService() => _CommonService(ApiClient.client);

  @GET('/application-status')
  Future<AppStatusResponse> getApplicationStatus();

  @POST('/application-status/contract')
  Future<ApiResponse<dynamic>> getContractInfo();

  // const getApplicationStatusApiEndpoint = "application-status";
  // const getContractInfoApiEndpoint = "application-status/contract";
}
