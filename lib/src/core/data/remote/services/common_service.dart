import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'common_service.g.dart';

@RestApi()
abstract class CommonService {
  factory CommonService() => _CommonService(ApiClient.client);

  // @POST('/contract/contract/get_searched_contracts_for_bo_app')
  // Future<ApiResponse<List<ContractInfoResponse>>> getSearchedContracts(
  //   @Body() ContractSearchParam body,
  // );

  // @POST('/contract/{contractId}/asset/{assetId}/update_ob_status')
  // Future<MessageResponse> updateOwnerBookStatus(
  //   @Path('contractId') int contractId,
  //   @Path('assetId') int assetId,
  //   @Body() OwnerbookStatusRequest body,
  // );

  // @POST('/contract/{contractId}/ob-transfer/upload-signature')
  // Future<ApiResponse> uploadSignature(
  //   @Path('contractId') int contractId,
  //   @Body() SignatureParam body,
  // );
}
