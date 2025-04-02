import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_chat/theme/colors.dart';

ThemeData theme = ThemeData(
  textTheme: textTheme,
  iconTheme: const IconThemeData(size: 60),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.lightBlue,
    shape: RoundedRectangleBorder(),
    textTheme: ButtonTextTheme.primary,
  ),
  cardColor: Colors.lightBlue,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.lightBlue),
);

final TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(fontSize: 42, color: lightDarkGreen, fontWeight: FontWeight.w500),
  displayMedium: GoogleFonts.roboto(fontSize: 42, color: Colors.white, fontWeight: FontWeight.w500),
  displaySmall: GoogleFonts.roboto(fontSize: 36, color: lightDarkGreen, fontWeight: FontWeight.w500),
  headlineLarge: GoogleFonts.roboto(fontSize: 32, color: darkGrey, fontWeight: FontWeight.w500),
  headlineMedium: GoogleFonts.roboto(fontSize: 42, color: Colors.black, fontWeight: FontWeight.w500),
  headlineSmall: GoogleFonts.roboto(fontSize: 42, color: Colors.white, fontWeight: FontWeight.w700),
  titleLarge: GoogleFonts.roboto(fontSize: 36, color: Colors.black, fontWeight: FontWeight.w500),
  titleMedium: GoogleFonts.roboto(fontSize: 32, color: orangeBackground, fontWeight: FontWeight.w500),
  bodyLarge: GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.w400, color: lightDarkGreen),
  bodyMedium: GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.w400, color: darkGrey),
  labelLarge: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w500, color: lighterBlack),
  labelSmall: GoogleFonts.roboto(fontSize: 36, color: darkGrey, fontWeight: FontWeight.w500),
);
