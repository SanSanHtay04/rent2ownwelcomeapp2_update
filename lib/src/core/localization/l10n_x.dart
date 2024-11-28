import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rent2ownwelcomeapp/src/core/base/error.dart';

List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

List<LocalizationsDelegate> get delegates =>
    AppLocalizations.localizationsDelegates;

extension LocalizationsX on BuildContext {
  AppLocalizations get tr {
    return AppLocalizations.of(this)!;
  }

  String l10nErrorMessage<T>(AppError error) {
    switch (error.errorType) {
      case AppErrorType.defaultServerError:
        return tr.errorDefaultServer;
      case AppErrorType.defaultError:
        return tr.errorDefault;
      case AppErrorType.noConnection:
        return tr.errorNoInternet;
      case AppErrorType.connectTimeout:
        return tr.errorConnectTimeout;
      case AppErrorType.unauthorized:
        return tr.errorUnauthorized;
      case AppErrorType.unGrantedUser:
        return tr.errorUnGranted;
      case AppErrorType.emptyContractInfo:
        return tr.errorEmptyContractInfo((error.data as String?) ?? "");
      // case AppErrorType.badRequest:
      // case AppErrorType.forbidden:
      // case AppErrorType.notFound:
      // case AppErrorType.serverError:
    }
  }
}
