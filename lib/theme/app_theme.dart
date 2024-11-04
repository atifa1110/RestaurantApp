import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const Color scaffoldColor = Color(0xFFFEFEFE);
  static const Color orange = Color(0xFFFAB400);
  static const Color green = Color(0xFF11AC6A);
  static const Color greenGrey = Color(0xFFD6FFEE);
  static const Color white = Colors.white;
  static const Color lightGrey = Color(0xFFF6F7FB);
  static const Color grey = Color(0xFFA4A4A4);
  static const Color darkGrey = Color(0xFF3F3F3F);
  static const Color black = Color(0xFF111111);

  static const Color primary = Color(0xFF6750A4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF4F378B);
  static const Color secondary = Color(0xFF625B71);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color onSecondaryContainer = Color(0xFF4A4458);
  static const Color tertiary = Color(0xFF7D5260);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFFFD8E4);
  static const Color onTertiaryContainer = Color(0xFF633B48);
  static const Color error = Color(0xFFB3261E);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFF9DEDC);
  static const Color onErrorContainer = Color(0xFF8C1D18);
  static const Color surface= Color(0xFFFEF7FF);
  static const Color onSurface = Color(0xFF1D1B20);
  static const Color surfaceVariant = Color(0xFFE7E0EC);
  static const Color onSurfaceVariant = Color(0xFF49454F);
  static const Color surfaceContainerHighest = Color(0xFFE6E0E9);
  static const Color surfaceContainerHigh= Color(0xFFECE6F0);
  static const Color surfaceContainer = Color(0xFFF3EDF7);
  static const Color surfaceContainerLow = Color(0xFFF7F2FA);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color inverseSurfaceHigh = Color(0xFF322F35);
  static const Color inverseOnSurface = Color(0xFFF5EFF7);
  static const Color surfaceTint= Color(0xFF6750A4);
  static const Color surfaceTintColor = Color(0xFF6750A4);
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFCAC4D0);
  static const Color background = Color(0xFFFEF7FF);
  static const Color onBackground = Color(0xFF1D1B20);

  static const Color darkPrimary = Color(0xFFD0BCFF);
  static const Color darkOnPrimary = Color(0xFF381E72);
  static const Color darkPrimaryContainer = Color(0xFF4F378B);
  static const Color darkOnPrimaryContainer = Color(0xFFEADDFF);
  static const Color darkSecondary = Color(0xFFCCC2DC);
  static const Color darkOnSecondary = Color(0xFF332D41);
  static const Color darkSecondaryContainer = Color(0xFF4A4458);
  static const Color darkOnSecondaryContainer = Color(0xFFE8DEF8);
  static const Color darkTertiary = Color(0xFFEFB8C8);
  static const Color darkOnTertiary = Color(0xFF492532);
  static const Color darkTertiaryContainer = Color(0xFF633B48);
  static const Color darkOnTertiaryContainer = Color(0xFFFFD8E4);
  static const Color darkError = Color(0xFFF2B8B5);
  static const Color darkOnError = Color(0xFF601410);
  static const Color darkErrorContainer = Color(0xFF8C1D18);
  static const Color darkOnErrorContainer = Color(0xFFF9DEDC);
  static const Color darkSurface = Color(0xFF141218);
  static const Color darkOnSurface = Color(0xFFE6E0E9);
  static const Color darkSurfaceVariant = Color(0xFF49454F);
  static const Color darkOnSurfaceVariant = Color(0xFFCAC4D0);
  static const Color darkSurfaceContainerHighest = Color(0xFF36343B);
  static const Color darkSurfaceContainerHigh= Color(0xFF2B2930);
  static const Color darkSurfaceContainer = Color(0xFF211F26);
  static const Color darkSurfaceContainerLow = Color(0xFF1D1B20);
  static const Color darkSurfaceContainerLowest = Color(0xFF0F0D13);
  static const Color darkInverseSurfaceHigh = Color(0xFFE6E0E9);
  static const Color darkInverseOnSurface = Color(0xFF322F35);
  static const Color darkSurfaceTint= Color(0xFFD0BCFF);
  static const Color darkSurfaceTintColor = Color(0xFFD0BCFF);
  static const Color darkOutline = Color(0xFF938F99);
  static const Color darkOutlineVariant = Color(0xFF49454F);
  static const Color darkBackground = Color(0xFF141218);
  static const Color darkOnBackground = Color(0xFFE6E0E9);

  static TextStyle headline1 = TextStyle(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: black,
  );

  static TextStyle headline2 = TextStyle(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: black,
  );

  static TextStyle headline3 = TextStyle(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: black,
  );

  static TextStyle text1 = TextStyle(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: black,
  );

  static TextStyle text2 = TextStyle(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: black,
  );

  static TextStyle subText1 = TextStyle(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: black,
  );

  static List<BoxShadow> getShadow(Color color) {
    return [
      BoxShadow(
        color: color.withOpacity(0.2),
        offset: const Offset(0, 4),
        blurRadius: 20,
        spreadRadius: 4,
      ),
    ];
  }

  static List<BoxShadow> getSmallShadow({Color color = grey}) {
    return [
      BoxShadow(
        color: AppThemes.grey.withOpacity(0.2),
        offset: const Offset(0, 2),
        blurRadius: 4,
      ),
    ];
  }

  static List<BoxShadow> getNavBarShadow({Color color = grey}) {
    return [
      BoxShadow(
        color: AppThemes.grey.withOpacity(0.2),
        offset: const Offset(0, -2),
        blurRadius: 4,
      ),
    ];
  }

  static final TextTheme myTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 98,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 49,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontSize: 35,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ThemeData.light().colorScheme.copyWith(
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      surfaceContainer: surfaceContainer,
      surfaceContainerHighest: surfaceContainerHighest,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainerLowest: surfaceContainerLowest,
      outline: outline,
      outlineVariant: outlineVariant,
    ),

    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: myTextTheme,
    appBarTheme: const AppBarTheme(elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ThemeData.dark().colorScheme.copyWith(
      primary: darkPrimary,
      onPrimary: darkOnPrimary,
      primaryContainer: darkPrimaryContainer,
      onPrimaryContainer: darkOnPrimaryContainer,
      secondary: darkSecondary,
      onSecondary: darkOnSecondary,
      secondaryContainer: darkSecondaryContainer,
      onSecondaryContainer: darkOnSecondaryContainer,
      tertiary: darkTertiary,
      onTertiary: darkOnTertiary,
      tertiaryContainer: darkTertiaryContainer,
      onTertiaryContainer: darkOnTertiaryContainer,
      error: darkError,
      onError: darkOnError,
      errorContainer: darkErrorContainer,
      onErrorContainer: darkOnErrorContainer,
      surface: darkSurface,
      onSurface: darkOnSurface,
      onSurfaceVariant: darkOnSurfaceVariant,
      surfaceContainer: darkSurfaceContainer,
      surfaceContainerHighest: darkSurfaceContainerHighest,
      surfaceContainerHigh: darkSurfaceContainerHigh,
      surfaceContainerLow: darkSurfaceContainerLow,
      surfaceContainerLowest: darkSurfaceContainerLowest,
      outline: darkOutline,
      outlineVariant: darkOutlineVariant,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: myTextTheme,
    appBarTheme: const AppBarTheme(elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkSecondary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(),
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.all(
            Radius.circular(0),
          ),
        ),
      ),
    ),
  );

}