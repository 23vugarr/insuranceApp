import 'package:flutter/material.dart';
import 'package:pasha_insurance/ui/widgets/dialog/custom_dialog.dart';

import '../../../../constants/style/app_colors.dart';
import 'result_dialog.dart';

Future showSuccessDialog(BuildContext context, {required String title, String? description, Function()? onConfirmed}) {
  return showCustomDialog(
    context: context, 
    hasTextFields: false,
    dialogBuilder: () {  
      return _SuccessDialog(
        title: title,
        description: description,
        onConfirmed: onConfirmed,
      );
    }
  );
} 

class _SuccessDialog extends ResultDialog {
  final String title;
  final String? description;
  final Function()? onConfirmed;

  const _SuccessDialog({required this.title, this.description, this.onConfirmed});

  @override
  Color getButtonColor(BuildContext context) => AppColors.primary;

  @override
  String? getDescription() => description; 

  @override
  String getTitle(BuildContext context) => title;

  @override
  Color getTitleColor(BuildContext context) => AppColors.primary;

  @override
  Color getDescriptionColor(BuildContext context) => AppColors.black;

  @override
  Function()? onButtonClick(context) => onConfirmed ?? super.onButtonClick(context);
  
  @override
  Widget getIconWidget() => const Icon(Icons.done, color: AppColors.primary, size: 50);
} 