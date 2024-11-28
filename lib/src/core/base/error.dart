import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/localization/l10n_x.dart';

const defaultErrorMessage = 'Oops! Something when wrong with server';


enum AppErrorType {
  defaultServerError,
  defaultError,
  noConnection,
  connectTimeout,
  unauthorized,
  unGrantedUser,
  // badRequest,
  // notFound,
  // forbidden,
  // serverError,
  emptyContractInfo,
}

class AppError<T> {
  final AppErrorType errorType;
  final T? data;

  AppError(this.errorType, {this.data});

  factory AppError.defaultServerError() =>
      AppError(AppErrorType.defaultServerError);

  factory AppError.defaultError() => AppError(AppErrorType.defaultError);
}

extension AppErrorX on AppError? {
  String errorMessage(BuildContext context, String message) {
    if (this == null) return message;
    return context.l10nErrorMessage(this!);
  }
}