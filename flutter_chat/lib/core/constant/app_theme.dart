import 'package:chatapp/core/constant/colors.dart';
import 'package:flutter/material.dart';

ThemeData englishTheme = ThemeData(
  // scaffoldBackgroundColor: AppColors.blue,
  fontFamily: "Lato",
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.bold,
        height: 2,
        fontSize: 14),
    // bodyMedium: TextStyle(
    //     color: AppColors.grey,
    //     fontWeight: FontWeight.bold,
    //     height: 2,
    //     fontSize: 14),
  ),
  primarySwatch: Colors.blue,
);


ThemeData arabicTheme = ThemeData(
  // scaffoldBackgroundColor: AppColors.blue,
  fontFamily: "Cairo",
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.bold,
        height: 2,
        fontSize: 14),
  ),
  primarySwatch: Colors.blue,
);
