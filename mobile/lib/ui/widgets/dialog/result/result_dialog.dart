// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/ui/widgets/buttons/primary_button.dart';
import 'package:pasha_insurance/ui/widgets/dialog/loader_dialog.dart';
import 'package:pasha_insurance/ui/widgets/dialog/result/fail_dialog.dart';
import 'package:pasha_insurance/ui/widgets/dialog/result/success_dialog.dart';

Future<bool> makeResultantRequest<T>({
  required BuildContext context,
  required Future<T> asyncRequest,
  required bool Function(T resp) isSuccessful,
  Function(bool success, T resp)? onResult,
  bool showDialogOnSuccess = true,
  bool showDialogOnFail = true,
  bool popBeforeOnResult = true,
  String? Function(T resp)? successTitle,
  String? Function(T resp)? successDesciption,
  String? Function(T resp)? failTitle,
  String? Function(T resp)? failDescription,
}) async {
  showLoaderDialog(context);
  T resp = await asyncRequest;
  bool success = isSuccessful(resp);
  if (popBeforeOnResult) {
    Navigator.of(context, rootNavigator: true).pop();
    await onResult?.call(success, resp);
  } else {
    await onResult?.call(success, resp);
    Navigator.of(context, rootNavigator: true).pop();
  }
  if (success) {
    if (showDialogOnSuccess) {
      String? userSuccessTitle = successTitle != null ? successTitle(resp) : null;
      showSuccessDialog(context, title: userSuccessTitle ?? "Success", description: successDesciption != null ? successDesciption(resp) : null);
    } else {
      return success;
    }
  } else if (showDialogOnFail) {
    showFailDialog(context, title: failTitle != null ? failTitle(resp) : null, description: failDescription != null ? failDescription(resp) : null);
  }
  return success;
}

abstract class ResultDialog extends StatelessWidget {
  String getTitle(BuildContext context);
  String? getDescription();
  Widget getIconWidget();
  Function()? onButtonClick(BuildContext context) {
    Navigator.of(context).pop();
    return null;
  }

  Color getTitleColor(BuildContext context);
  Color getDescriptionColor(BuildContext context);
  Color getButtonColor(BuildContext context);

  const ResultDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide.none),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      contentPadding: EdgeInsets.zero,
      backgroundColor: AppColors.white.withOpacity(0.1),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getIconWidget(),
                const SizedBox(height: 10),
                Text(getTitle(context), style: AppTextStyles.subtitle1Size16.copyWith(color: getTitleColor(context)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                getDescription() != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(getDescription()!, style: AppTextStyles.overline.copyWith(color: getDescriptionColor(context)), textAlign: TextAlign.center),
                      )
                    : const SizedBox(),
                PrimaryButton(
                  label: "Okay",
                  color: getButtonColor(context),
                  textColor: AppColors.white,
                  onTap: () {
                    onButtonClick(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
