import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/strings/local_consts.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';

class AppThemes {
  AppThemes._();

  static ThemeData light(BuildContext context) {
    return ThemeData(
      fontFamily: LocalConsts.kFontFamily,
      brightness: Brightness.light,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: AppColors.darkGreyColor, fontFamily: LocalConsts.kFontFamily),
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      fontFamily: LocalConsts.kFontFamily,
      brightness: Brightness.dark,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: AppColors.white, fontFamily: LocalConsts.kFontFamily),
    );
  }
}
