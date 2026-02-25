import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jenosize/ui/styles/app_colors.dart';

class AppTheme {
  const AppTheme();

  ThemeData theme(
    ColorScheme colorScheme, {
    Iterable<ThemeExtension<dynamic>>? extensions,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.ibmPlexSansThaiTextTheme().apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      extensions: extensions,
    );
  }

  ThemeData light() {
    return theme(lightScheme(), extensions: [AppColors.light()]);
  }

  ThemeData dark() {
    return theme(darkScheme(), extensions: [AppColors.dark()]);
  }

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00bf40),
      surfaceTint: Color(0xff00bf40),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffB3F2C7),
      onPrimaryContainer: Color(0xff003913),
      secondary: Color(0xff595d72),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdee1f9),
      onSecondaryContainer: Color(0xff424659),
      tertiary: Color(0xff75546f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd7f5),
      onTertiaryContainer: Color(0xff5b3d57),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xffE0E5EC),
      onSurface: Color(0xff2D3142),
      onSurfaceVariant: Color(0xff70788A),
      outline: Color(0xffA3B1C6),
      outlineVariant: Color(0xffC8D0DF),
      shadow: Color(0xffA3B1C6),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff22252B),
      inversePrimary: Color(0xff1ed45a),
      primaryFixed: Color(0xffB3F2C7),
      onPrimaryFixed: Color(0xff00210A),
      primaryFixedDim: Color(0xff00bf40),
      onPrimaryFixedVariant: Color(0xff008F30),
      secondaryFixed: Color(0xffdee1f9),
      onSecondaryFixed: Color(0xff161b2c),
      secondaryFixedDim: Color(0xffc2c5dd),
      onSecondaryFixedVariant: Color(0xff424659),
      tertiaryFixed: Color(0xffffd7f5),
      onTertiaryFixed: Color(0xff2c1229),
      tertiaryFixedDim: Color(0xffe3bada),
      onTertiaryFixedVariant: Color(0xff5b3d57),
      surfaceDim: Color(0xffD1D7E0),
      surfaceBright: Color(0xffEBF0F5),
      surfaceContainerLowest: Color(0xffFFFFFF),
      surfaceContainerLow: Color(0xffF2F5F8),
      surfaceContainer: Color(0xffE0E5EC),
      surfaceContainerHigh: Color(0xffD4DADD),
      surfaceContainerHighest: Color(0xffC6CCD0),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff1ed45a),
      surfaceTint: Color(0xff1ed45a),
      onPrimary: Color(0xff003913),
      primaryContainer: Color(0xff00521C),
      onPrimaryContainer: Color(0xffB3F2C7),
      secondary: Color(0xffc2c5dd),
      onSecondary: Color(0xff2b3042),
      secondaryContainer: Color(0xff424659),
      onSecondaryContainer: Color(0xffdee1f9),
      tertiary: Color(0xffe3bada),
      onTertiary: Color(0xff43273f),
      tertiaryContainer: Color(0xff5b3d57),
      onTertiaryContainer: Color(0xffffd7f5),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff22252B),
      onSurface: Color(0xffE3E1E9),
      onSurfaceVariant: Color(0xff989BA2),
      outline: Color(0xff4A4D57),
      outlineVariant: Color(0xff33363F),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffE0E5EC),
      inversePrimary: Color(0xff00bf40),
      primaryFixed: Color(0xffB3F2C7),
      onPrimaryFixed: Color(0xff00210A),
      primaryFixedDim: Color(0xff1ed45a),
      onPrimaryFixedVariant: Color(0xff008F30),
      secondaryFixed: Color(0xffdee1f9),
      onSecondaryFixed: Color(0xff161b2c),
      secondaryFixedDim: Color(0xffc2c5dd),
      onSecondaryFixedVariant: Color(0xff424659),
      tertiaryFixed: Color(0xffffd7f5),
      onTertiaryFixed: Color(0xff2c1229),
      tertiaryFixedDim: Color(0xffe3bada),
      onTertiaryFixedVariant: Color(0xff5b3d57),
      surfaceDim: Color(0xff1A1C21),
      surfaceBright: Color(0xff363A43),
      surfaceContainerLowest: Color(0xff15171B),
      surfaceContainerLow: Color(0xff1C1E23),
      surfaceContainer: Color(0xff22252B),
      surfaceContainerHigh: Color(0xff2A2D35),
      surfaceContainerHighest: Color(0xff33363F),
    );
  }
}
