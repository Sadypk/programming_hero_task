import 'package:flutter/cupertino.dart';
import 'package:programming_hero_task/theme/app_colors.dart';

class AppTextStyles {
  static TextStyle commonTextStyleWhite = TextStyle(
    fontSize: 20,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle commonTextStylePurple = TextStyle(
    fontSize: 20,
    color: AppColors.primaryPurple,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headerTextStyle = TextStyle(
    fontSize: 40,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle timerTextStylePurple = TextStyle(
    fontSize: 15,
    color: AppColors.primaryPurple,
    fontWeight: FontWeight.bold,
  );
}
