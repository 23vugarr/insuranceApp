import 'package:flutter/material.dart';

class EmptySpace {  // todo: change to Gap()
  EmptySpace._();

  static Widget vertical(double value) => SizedBox(height: value);
  static Widget horizontal(double value) => SizedBox(width: value);
}