import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.accentGrey,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: 'Lato',
      appBarTheme: const AppBarTheme(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: AppColors.primaryRed,
          iconTheme: IconThemeData(color: Colors.white),
          toolbarTextStyle: TextStyle(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white)),
     
      textTheme: const TextTheme(
           headlineLarge:  TextStyle(
          color: AppColors.black,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
           headlineMedium:  TextStyle(
          color: AppColors.black,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        labelLarge:  TextStyle(
          color: AppColors.black,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
     
        labelMedium:  TextStyle(
          color: AppColors.white,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        labelSmall: TextStyle(
          color: AppColors.white,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      ),
    );
  }
}
