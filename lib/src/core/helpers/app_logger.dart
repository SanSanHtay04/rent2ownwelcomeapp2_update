import 'package:logger/logger.dart';



class AppLogger {
  static final _log = Logger(
    printer: PrettyPrinter(
      methodCount: 10,
      errorMethodCount: 20,
      colors: false,
    ),
  );

  static e(String message, [StackTrace? stackTrace]) {
    // if (!kDebugMode) {
    //   FirebaseCrashlytics.instance.recordError(
    //     message,
    //     stackTrace ?? StackTrace.current,
    //     fatal: false,
    //   );
    // }
    _log.e(message);
  }

  static i(String message) {
    _log.i(message);
  }

  static d(String message) {
    _log.d(message);
  }

  static w(String message) {
    // if (!kDebugMode) {
    //   FirebaseCrashlytics.instance.recordError(
    //     message,
    //     StackTrace.current,
    //     fatal: true,
    //   );
    // }
    _log.w(message);
  }
}

