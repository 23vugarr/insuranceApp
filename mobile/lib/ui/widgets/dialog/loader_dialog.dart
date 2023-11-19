import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pasha_insurance/ui/widgets/dialog/custom_dialog.dart';
import '../../../constants/style/app_colors.dart';
import '../../../constants/style/app_text_styles.dart';
import '../custom/loading_spinner.dart';

Future<void> showLoaderDialog(BuildContext scaffoldContext) {
  return showCustomDialog(
    context: scaffoldContext,
    dialogBuilder: () => _LoaderDialog(),
    hasTextFields: false
  );
}

class _LoaderDialog extends StatelessWidget {
  final borderRadius = BorderRadius.circular(20);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: borderRadius, side: BorderSide.none),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        contentPadding: EdgeInsets.zero,
        backgroundColor: AppColors.white.withOpacity(0.1),
        content: ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            color: AppColors.white,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Loading...", style: AppTextStyles.subtitle1Size16),
                  SizedBox(height: 10),
                  LoadingSpinner(size: 25),
                  SizedBox(height: 10),
                  Text("Loading... Please be patient", style: AppTextStyles.overline)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
