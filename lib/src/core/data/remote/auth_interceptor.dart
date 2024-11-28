import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

class AuthInterceptor extends Interceptor {
  final LocalAuthProvider _authProvider;
  AuthInterceptor(this._authProvider);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers["x-device-id"] = _authProvider.deviceId;
    options.headers["android-id"] = _authProvider.androidId;

    final token = _authProvider.accessToken;
    if (!token.isNullOrEmpty) {
      options.headers['access-token'] = '$token';
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
