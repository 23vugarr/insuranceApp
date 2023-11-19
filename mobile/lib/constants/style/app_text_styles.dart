import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle body2Size14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 17 / 14);
  static const TextStyle body1Size16 = TextStyle(fontSize: 16, letterSpacing: 0.5, fontWeight: FontWeight.w400, height: 20 / 16);
  static const TextStyle body1Size18 = TextStyle(fontSize: 18, letterSpacing: 0.5, fontWeight: FontWeight.w400, height: 1);

  static const TextStyle underlineSize10 = TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5, decoration: TextDecoration.underline, height: 1);
  static       TextStyle underlineSize12 = captionSize12.copyWith(decoration: TextDecoration.underline, height: 1);
  static const TextStyle underlineBody2Size14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 17 / 14, decoration: TextDecoration.underline);

  static const TextStyle overline = TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5, height: 12 / 10);
  static       TextStyle overlineSize12 = captionSize12.copyWith(decoration: TextDecoration.lineThrough, height: 1);
  static       TextStyle greyOverline = overline.copyWith(fontSize: 12);

  static const TextStyle subtitle1Size16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 20 / 16);

  static const TextStyle headline2Size20 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15, height: 24 / 20);
  static const TextStyle headline1Size24 = TextStyle(fontSize: 24, fontWeight: FontWeight.w400);

  static const TextStyle header1Style = TextStyle(fontSize: 24, fontWeight: FontWeight.w800);

  static const TextStyle captionSize12 = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 15 / 12);
  static const TextStyle captionSize13 = TextStyle(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 15 / 12);

  static const TextStyle boldSize12 = TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.4, height: 14.63 / 12);
  static const TextStyle boldSize14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.4, height: 1);
  static const TextStyle boldSize16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5, height: 1);
  static const TextStyle boldSize24 = TextStyle(fontSize: 24, fontWeight: FontWeight.w800, height: 1);

  static const TextStyle semiBoldSize14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5, height: 1);
  static const TextStyle buttonSize14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, height: 17 / 14);
}
