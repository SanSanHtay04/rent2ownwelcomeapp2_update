import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const AppState._();

  const factory AppState.initial() = _initial;

  const factory AppState.success({
    required ThemeMode themeMode,
    required String languageCode,
  }) = _success;

  ThemeMode get themeMode => maybeMap(
        orElse: () => ThemeMode.system,
        success: (state) => state.themeMode,
      );

  String get languageCode => maybeMap(
        orElse: () => '',
        success: (state) => state.languageCode,
      );

  bool get isEnglish => maybeMap(
        orElse: () => true,
        success: (state) =>
            state.languageCode.isEmpty || state.languageCode.contains('en'),
      );
}