import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pasha_insurance/models/enum/awareness_level.dart';

class ToastNotifier {
  ToastNotifier._();

  static showToast({required String message, AwarenessLevel? awarenessLevel}) {
    late final Color toastColor;

    switch (awarenessLevel) {
      case AwarenessLevel.SUCCESS:
        toastColor = Colors.blueAccent;
        break;
      case AwarenessLevel.WARNING:
        toastColor = Colors.amber;
        break;
      case AwarenessLevel.ERROR:
        toastColor = Colors.red;
        break;
      default:
        toastColor = Colors.grey;
    }

    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: toastColor, textColor: Colors.white, fontSize: 16.0);
  }
}
