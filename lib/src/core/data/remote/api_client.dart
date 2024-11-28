import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:rent2ownwelcomeapp/src/core/core.dart';

class ApiClient {
  ApiClient._();

  static late final LocalAuthProvider _authProvider;

  static const int _connectTimeout = 30 * 1000;
  static const int _sendTimeout = 90 * 1000;
  static const int _receiveTimeout = 90 * 1000;

  static _parseAndDecode(String response) {
    return jsonDecode(response);
  }

  static parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  static initialize(LocalAuthProvider authProvider) {
    _authProvider = authProvider;
  }

  static Dio get client {
    final options = BaseOptions(
      baseUrl: EnvConfig.baseUrl,
      // connectTimeout: _connectTimeout,
      // sendTimeout: _sendTimeout,
      // receiveTimeout: _receiveTimeout,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.acceptHeader: 'application/json',
      },
    );
    final dio = Dio(options);

    dio.interceptors.add(AuthInterceptor(_authProvider));
    if (kDebugMode) {
      dio.interceptors
          .add(PrettyDioLogger(requestBody: true, requestHeader: true));
    }

    // Isolate JSON decode
    //  (dio.transformer as FusedTransformer).jsonDecodeCallback = parseJson;

    return dio;
  }

  Future<Response> post(String url, {dynamic body, dynamic options}) =>
      client.post(url, data: body, options: options);
}
