import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

class AuthInterceptor extends Interceptor {
  final LocalAuthProvider _authProvider;
  AuthInterceptor(this._authProvider);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // This is for MiscService APIs
    options.headers["x-device-id"] = _authProvider.deviceId;

    final token = _authProvider.accessToken;
    if (!token.isNullOrEmpty) {
      // This is for MiscService APIs
      options.headers['access-token'] = '$token';
      // This is for CommonService APIs
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.badResponse &&
        err.response?.statusCode == 401) {
      _authProvider.logout();
    }
    super.onError(err, handler);
  }
}
