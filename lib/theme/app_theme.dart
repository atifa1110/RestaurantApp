import 'package:flutter/material.dart';
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

  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color secondaryColor = Color(0xFF6B38FB);
  static const Color darkPrimaryColor = Color(0xFF000000);
  static const Color darkSecondaryColor = Color(0xff64ffda);

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
      primary: primaryColor,
      onPrimary: Colors.black,
      secondary: secondaryColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: myTextTheme,
    appBarTheme: const AppBarTheme(elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
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
      primary: darkPrimaryColor,
      onPrimary: Colors.black,
      secondary: darkSecondaryColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: myTextTheme,
    appBarTheme: const AppBarTheme(elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
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