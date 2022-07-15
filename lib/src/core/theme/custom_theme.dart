import 'package:aamako_maya/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 27.sm,
      ),
      textTheme: TextTheme(
        //Drawer Label Style
        titleSmall: TextStyle(
          letterSpacing: 0,
          color: AppColors.black,
          fontFamily: 'Lato',
          fontWeight: FontWeight.normal,
          fontSize: 20.sp,
        ),
        headlineLarge: TextStyle(
          color: AppColors.black,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
          fontSize: 25.sp,
        ),
        headlineMedium: TextStyle(
          color: AppColors.black,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
        labelLarge: TextStyle(
          color: AppColors.black,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
          fontSize: 22.sp,
        ),

        displaySmall: TextStyle(
          color: AppColors.white,
          fontFamily: 'Lato',
          fontWeight: FontWeight.normal,
          fontSize: 20.sp,
          letterSpacing: 0,
        ),

        // button:TextStyle(
        //   color: AppColors.black,
        //   fontFamily: 'Lato',
        //   fontWeight: FontWeight.normal,
        //   fontSize: 20.sp,
        // ),
        //weekly tips
        labelMedium: TextStyle(
          color: AppColors.black,
          fontFamily: 'Lato',
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,
          letterSpacing: 0,
        ),
        labelSmall: TextStyle(
          color: AppColors.black,
          fontFamily: 'Lato',
          letterSpacing: 0,
          fontWeight: FontWeight.w500,
          fontSize: 15.sp,
        ),
        bodySmall: TextStyle(
          color: AppColors.black,
          fontFamily: 'Lato',
          letterSpacing: 0,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
