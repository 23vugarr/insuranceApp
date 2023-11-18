import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasha_insurance/ui/widgets/text_fields/auth_text_field.dart';
import 'package:pasha_insurance/utils/helpers/reg_exp_helper.dart';
import 'package:pasha_insurance/utils/helpers/uppercase_text_input_formatter.dart';
import 'package:pasha_insurance/utils/helpers/validator.dart';

class FinCodeTextField extends StatelessWidget {
  const FinCodeTextField({super.key,
    required TextEditingController finCodeController,
  }) : _finCodeController = finCodeController;

  final TextEditingController _finCodeController;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      title: "FIN Code",
      controller: _finCodeController,
      hintText: "Your FIN",
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.characters,
      validator: Validator.validateFinCode,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(RegExpHelper.digitsAndLatinLettersValidation)),
        UppercaseTextInputFormatter(),
        LengthLimitingTextInputFormatter(7),
      ],
    );
  }
}
