import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dimensions.dart';

class Themes {
  const Themes._internal();

  static const primaryColor = Color(0xFF306b92);
  static const secondaryColor = Color(0xFF91D234);
  // static const hintColor = Color(0xFFC0F0E8);
  // static const canvasColor = Colors.transparent;

  static ThemeData lightTheme = _createTheme(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      secondary: secondaryColor,
      brightness: Brightness.light,
    ),
    brightness: Brightness.light,
  );
  static ThemeData darkTheme = _createTheme(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      secondary: secondaryColor,
      brightness: Brightness.dark,
    ),
    brightness: Brightness.dark,
  );

  static ThemeData _createTheme({
    required ColorScheme colorScheme,
    required Brightness brightness,
  }) {
    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      //hintColor: hintColor,
      // canvasColor: colorScheme.surface,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: GoogleFonts.robotoTextTheme().apply(
          bodyColor: Colors.grey.shade600, // colorScheme.secondary,
          displayColor: Colors.grey //colorScheme.secondary,
          ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        titleSpacing: 4,
        color: colorScheme.secondaryContainer,
        centerTitle: false,
      ),
      tabBarTheme: TabBarTheme(
       labelColor: colorScheme.secondary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
      ),

      cardTheme: CardTheme(shape: kRoundedRectangleBorder16),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: kPaddingHorizontal16 + kPaddingVertical12,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
          borderRadius: kBorderRadius16,
        ),
        errorStyle: const TextStyle(color: Colors.red),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
       // splashColor: colorScheme.primaryContainer,
      ),
      listTileTheme: const ListTileThemeData(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius16),
        minLeadingWidth: 16,
      ),
      dividerTheme: const DividerThemeData(thickness: 1),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        side: MaterialStateProperty.resolveWith((state) {
          if (state.contains(MaterialState.disabled)) {
            return const BorderSide(color: Colors.grey);
          }
          return BorderSide(color: colorScheme.secondary);
        }),
        foregroundColor: MaterialStateProperty.resolveWith((state) {
          if (state.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return colorScheme.secondary;
        }),
      )),
    );
  }
}
