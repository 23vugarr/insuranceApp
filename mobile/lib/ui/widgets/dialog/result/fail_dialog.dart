import 'package:flutter/material.dart';
import 'package:pasha_insurance/ui/widgets/dialog/custom_dialog.dart';
import '../../../../constants/style/app_colors.dart';
import 'result_dialog.dart';

Future showFailDialog(BuildContext context, {String? title, String? description}) {
  return showCustomDialog(
    context: context, 
    hasTextFields: false,
    dialogBuilder: () { 
      return _FailDialog(
        title: title,
        description: description
      );
    }
  );
}

class _FailDialog extends ResultDialog {
  final String? title;
  final String? description; 

  const _FailDialog({this.title, this.description});

  @override
  Color getButtonColor(BuildContext context) => AppColors.red;

  @override
  String? getDescription() => description; 

  @override
  String getTitle(BuildContext context) => title ?? "Something went wrong...";

  @override
  Color getTitleColor(BuildContext context) => AppColors.red;
  
  @override
  Color getDescriptionColor(BuildContext context) => AppColors.black;

  @override
  Widget getIconWidget() => const Icon(Icons.error, color: AppColors.red, size: 50);
}