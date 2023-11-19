// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasha_insurance/constants/style/animation_consts.dart';

Future<T?> showCustomDialog<T>(
    {required BuildContext context,
    bool barrierDismissible = false,
    Color? barrierColor,
    FutureOr<T> Function(dynamic)? onValue,
    required Widget Function() dialogBuilder,
    bool hasBackdropFilter = true,
    required bool hasTextFields}) async {
  final T? res = hasTextFields
      ? await Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
          barrierColor: Colors.transparent,
          opaque: false,
          pageBuilder: (_, __, ___) => DialogOpener(showDialog: () {
                return _showDialog(context: context, dialogBuilder: dialogBuilder, barrierDismissible: barrierDismissible, hasBackdropFilter: hasBackdropFilter);
              })))
      : await _showDialog(context: context, dialogBuilder: dialogBuilder, barrierDismissible: barrierDismissible, hasBackdropFilter: hasBackdropFilter);

  onValue?.call(res);
  return res;
}

Future<T?> _showDialog<T>({required BuildContext context, bool barrierDismissible = false, required Widget Function() dialogBuilder, bool hasBackdropFilter = true}) async {
  return await showGeneralDialog<T>(
    context: context,
    barrierLabel: "",
    useRootNavigator: true,
    transitionDuration: AnimationConsts.kAppAnimDuration,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.transparent, // barrierColor ?? AppColors.white.withOpacity(0.1),
    pageBuilder: (context, animation, secondaryAnimation) => const SizedBox(),
    transitionBuilder: (context, a1, a2, _) {
      final curvedValue = AnimationConsts.kAppAnimCurve.transform(a1.value);
      return Transform.scale(
        scale: curvedValue, // a1.value
        child: DefaultTextStyle(
          style: const TextStyle(),
          child: Opacity(
            opacity: a1.value,
            child: hasBackdropFilter
                ? BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 30,
                      sigmaY: 30,
                    ),
                    child: Center(
                      child: dialogBuilder.call(),
                    ),
                  )
                : Center(
                    child: dialogBuilder.call(),
                  ),
          ),
        ),
      );
    },
  );
}

class DialogOpener extends StatefulWidget {
  final Future<dynamic> Function() showDialog;

  const DialogOpener({super.key, required this.showDialog});

  @override
  State<DialogOpener> createState() => _DialogOpenerState();
}

class _DialogOpenerState extends State<DialogOpener> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await widget.showDialog();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();

    // Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   backgroundColor: ThemeState.isLightTheme(context) ? AppColors.white.withOpacity(0.1) : AppColors.darkBgColor.withOpacity(0.3),
    //   body: const SizedBox(),
    // );
  }
}