import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:files_manager/theme/color.dart';

final ThemeData DarkThemeData = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.dark,
  visualDensity: VisualDensity.standard,
  useMaterial3: true,

  //======= Text Theme =======/
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.cairo(color: Colors.white),
    bodyMedium: GoogleFonts.cairo(color: Colors.white),
    bodySmall: GoogleFonts.cairo(color: Colors.white),
    titleLarge: GoogleFonts.cairo(color: Colors.white),
    titleMedium: GoogleFonts.cairo(color: Colors.white),
    titleSmall: GoogleFonts.cairo(color: Colors.white),
    displayLarge: GoogleFonts.cairo(color: Colors.white),
    displayMedium: GoogleFonts.cairo(color: Colors.white),
    displaySmall: GoogleFonts.cairo(color: Colors.white),
    headlineLarge: GoogleFonts.cairo(color: Colors.white),
    headlineMedium: GoogleFonts.cairo(color: Colors.white),
    headlineSmall: GoogleFonts.cairo(color: Colors.white),
    labelLarge: GoogleFonts.cairo(color: Colors.white),
    labelMedium: GoogleFonts.cairo(color: Colors.white),
    labelSmall: GoogleFonts.cairo(color: Colors.white),
  ),

  //==========Button Theme ========///
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),

  //======Icon Theme ========//
  iconTheme: const IconThemeData(
    color: AppColors.gray,
    size: 30,
  ),

  //========= List tile Theme =======//
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.gray,
  ),

  //========= text field Theme =======//
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.cairo(color: Colors.grey.withOpacity(0.5)),
    labelStyle: GoogleFonts.cairo(color: AppColors.gray),
    focusColor: AppColors.dark,
    hoverColor: AppColors.dark,
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColors.dark),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColors.dark),
    ),
  ),

  //===== App Bar Theme======//
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.cairo(
      fontSize: 20,
      color: AppColors.white,
    ),
    backgroundColor: AppColors.primaryColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),

  //======= Tab Bar Theme =======//
  tabBarTheme: TabBarTheme(
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.dark,
    labelStyle: GoogleFonts.cairo(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: GoogleFonts.cairo(
      color: AppColors.dark,
    ),
    indicator: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(5),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
  ),

  //======= Elevated Button Theme =======//
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.cairo(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  //======= Card Theme =======//
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    margin: const EdgeInsets.all(8.0),
  ),

  //======= Popup Menu Theme =======//
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.primaryColor,
    textStyle: GoogleFonts.cairo(color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
final ThemeData LightThemeData = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.white,
  visualDensity: VisualDensity.standard,
  useMaterial3: true,

  //======= Text Theme =======/
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.cairo(color: Colors.black),
    bodyMedium: GoogleFonts.cairo(color: Colors.black),
    bodySmall: GoogleFonts.cairo(color: Colors.black),
    titleLarge: GoogleFonts.cairo(color: Colors.black),
    titleMedium: GoogleFonts.cairo(color: Colors.black),
    titleSmall: GoogleFonts.cairo(color: Colors.black),
    displayLarge: GoogleFonts.cairo(color: Colors.black),
    displayMedium: GoogleFonts.cairo(color: Colors.black),
    displaySmall: GoogleFonts.cairo(color: Colors.black),
    headlineLarge: GoogleFonts.cairo(color: Colors.black),
    headlineMedium: GoogleFonts.cairo(color: Colors.black),
    headlineSmall: GoogleFonts.cairo(color: Colors.black),
    labelLarge: GoogleFonts.cairo(color: Colors.black),
    labelMedium: GoogleFonts.cairo(color: Colors.black),
    labelSmall: GoogleFonts.cairo(color: Colors.black),
  ),

  //==========Button Theme ========///
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),

  //======Icon Theme ========//
  iconTheme: const IconThemeData(
    color: AppColors.primaryColor,
    size: 30,
  ),

  //========= List tile Theme =======//
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.primaryColor,
  ),

  //========= text field Theme =======//
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.cairo(color: Colors.grey.withOpacity(0.5)),
    labelStyle: GoogleFonts.cairo(color: AppColors.primaryColor),
    focusColor: AppColors.primaryColor,
    hoverColor: AppColors.gray,
    fillColor: AppColors.dark,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
  ),

  //===== App Bar Theme======//
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.cairo(
      fontSize: 20,
      color: AppColors.dark,
    ),
    backgroundColor: AppColors.primaryColor,
    iconTheme: const IconThemeData(
      color: AppColors.dark,
    ),
  ),

  //======= Tab Bar Theme =======//
  tabBarTheme: TabBarTheme(
    labelColor: AppColors.primaryColor,
    unselectedLabelColor: AppColors.dark,
    labelStyle: GoogleFonts.cairo(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: GoogleFonts.cairo(
      color: AppColors.dark,
    ),
    indicator: BoxDecoration(
      color: AppColors.dark,
      borderRadius: BorderRadius.circular(5),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
  ),

  //======= Elevated Button Theme =======//
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.cairo(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  //======= Card Theme =======//
  cardTheme: CardTheme(
    color: AppColors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    margin: const EdgeInsets.all(8.0),
  ),

  //======= Popup Menu Theme =======//
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.white,
    textStyle: GoogleFonts.cairo(color: AppColors.primaryColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
