// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pasha_insurance/ui/widgets/text_fields/auth_text_field.dart';
import 'package:pasha_insurance/utils/helpers/validator.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      title: "Password",
      controller: _passwordController,
      hintText: "Your password",
      obscureText: true,
      includeObscureTextIcon: true,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.none,
      validator: Validator.validatePassword,
    );
  }
}