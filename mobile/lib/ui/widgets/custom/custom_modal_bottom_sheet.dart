import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';

Future<T?> showCustomModalBottomSheet<T>({required BuildContext context, required Widget Function(BuildContext) builder, BoxConstraints? constraints, Color? backgroundColor, AnimationController? transitionAnimationController}) async {
  return showModalBottomSheet<T>(
    context: context,
    elevation: 0,
    useRootNavigator: true,
    isScrollControlled: true, //! gives ability to change bottomSheet's height dynamically
    clipBehavior: Clip.antiAlias, //! for avoiding background blurring
    backgroundColor: backgroundColor ?? AppColors.white.withOpacity(0.8),
    constraints: constraints,
    barrierColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    transitionAnimationController: transitionAnimationController,
    builder: builder,
  );
}
