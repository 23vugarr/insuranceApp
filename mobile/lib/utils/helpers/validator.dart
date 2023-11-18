import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/strings/app_consts.dart';
import 'package:pasha_insurance/utils/helpers/reg_exp_helper.dart';

class Validator {
  Validator._();

  static String? validateNameSurname(String? input) {
    input = input?.trim();
    if (input == null || input.isEmpty) {
      return "Cannot be blank!";
    }
    return null;
  }

  static String? validatePhoneNumber(String? input) {
    input = input?.trim();
    if (input == null || input.length != AppConsts.phoneNumberMask.length) {
      return "Invalid phone number!";
    }

    final int startIndexOfPrefix = AppConsts.phoneNumberMask.indexOf("(") + 1;
    if (!AppConsts.phoneNumberPrefixes.contains(int.parse(input.substring(startIndexOfPrefix, startIndexOfPrefix + 2)))) {
      return "Invalid prefix!";
    }

    return null;
  }

  static String? validateFinCode(String? input) {
    input = input?.trim();
    if (input == null || input.length != 7) {
      return "FIN should consist of 7 characters!";
    }

    return null;
  }

  static String? validatePassword(String? input) {
    input = input?.trim();
    if (input == null) {
      return "Password cannot be empty!";
    } else if (!RegExp(RegExpHelper.passwordValidation).hasMatch(input)) {
      return "Must contain 8-20 characters, A-Z, a-z, 0-9, @/\$/!/%/*/#/?/& !";
    } else if (input.length > 20) {
      return "Password cannot be longer than 20 characters!";
    }

    return null;
  }

  static String? validateConfirmPassword(String? input, {required String password}) {
    if (password != input) {
      return "Passwords do not match!";
    }
    
    return null;
  }

  static void handleDeletionOnChange({required TextEditingController phoneNumController, String? text}) {
    String prefix = AppConsts.phoneNumberCountryCode;
    int cursorPosition = phoneNumController.selection.base.offset;

    if (phoneNumController.text.length <= prefix.length) {
      phoneNumController.text = prefix;
      phoneNumController.selection = TextSelection.collapsed(offset: phoneNumController.text.length);
    } else {
      phoneNumController.text = text ?? "";
      phoneNumController.selection = TextSelection.collapsed(offset: cursorPosition <= prefix.length ? prefix.length + 1 : cursorPosition);
    }
  }
}
