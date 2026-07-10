import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme{
  static ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,),
    scaffoldBackgroundColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.secondaryColor),
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: AppColors.secondaryColor,
        fontSize: 20,
        fontFamily: 'jana',
        fontWeight: FontWeight.bold
      ),
    ),
    fontFamily: 'jana',
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.secondaryColor
      ),
      labelLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.white
      ),
      bodyMedium: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.white,
      indent: 20,
      endIndent: 20
    )
  );
}