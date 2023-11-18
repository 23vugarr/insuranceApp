import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:pasha_insurance/constants/style/animation_consts.dart';

class ScaleAnimatedWidget extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onLongPress;
  final Widget child;

  const ScaleAnimatedWidget({super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
  });
  
  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      scaleMinValue: 0.85,
      opacityMinValue: 1,
      scaleCurve: AnimationConsts.kAppAnimCurve,
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: child,
    );
  }
}
