// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pasha_insurance/constants/strings/app_consts.dart';
import 'package:pasha_insurance/constants/strings/app_router_consts.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/states/bloc/auth/auth_bloc.dart';
import 'package:pasha_insurance/ui/screens/auth/auth_screen.dart';
import 'package:pasha_insurance/ui/widgets/buttons/primary_button.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';
import 'package:pasha_insurance/ui/widgets/text_fields/auth_text_field.dart';
import 'package:pasha_insurance/ui/widgets/text_fields/fin_code_text_field.dart';
import 'package:pasha_insurance/ui/widgets/text_fields/password_text_field.dart';
import 'package:pasha_insurance/utils/extensions/formatter.dart';
import 'package:pasha_insurance/utils/helpers/reg_exp_helper.dart';
import 'package:pasha_insurance/utils/helpers/validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends AuthScreen {
  SignUpScreen({Key? key}) : super(key: UniqueKey());

  static void open(BuildContext context) {
    context.push(AppRouterConsts.signUpPath);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _finCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Function? startButtonLoading;
  Function? stopButtonLoading;

  @override
  bool isAloneInNavTree() => false; // this screen can be opened only from sign-in screen, so it is always false

  @override
  Form buildForm() => _buildSignUpForm();
  
  @override
  Widget buildButton(BuildContext context) => _buildSignUpButton(context);
  
  @override
  String getSuggestionText() => _buildBetterSignInText();

  @override
  void onSuggestionTap(BuildContext context) => _onBetterSignInBtnTap(context);


  Form _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FinCodeTextField(finCodeController: _finCodeController),
          EmptySpace.vertical(12),
          AuthTextField(
            title: "Phone number",
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            hintText: "Your phone number",
            textInputAction: TextInputAction.next,
            validator: Validator.validatePhoneNumber,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: AppConsts.phoneNumberMask,
                filter: {"#": RegExp(RegExpHelper.digitsValidation)},
                //? why do we need initialText
                initialText: _phoneNumberController.text.trim() !=
                        AppConsts.phoneNumberCountryCode
                    ? _phoneNumberController.text.trim()
                    : null,
              ),
            ],
            onChanged: (String? text) {
              Validator.handleDeletionOnChange(phoneNumController: _phoneNumberController, text: text);
            },
          ),
          EmptySpace.vertical(12),
          PasswordTextField(passwordController: _passwordController),
          EmptySpace.vertical(12),
          AuthTextField(
            title: "Confirm password",
            controller: _confirmPasswordController,
            hintText: "Your password",
            obscureText: true,
            includeObscureTextIcon: true,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.none,
            validator: (input) => Validator.validateConfirmPassword(input, password: _passwordController.text.trim()),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthorizedState || current is LoadingState || (current is FailedAuthorizationState && previous is LoadingState),
      listener: (context, state) {
        if (state is LoadingState) {
          startButtonLoading?.call();
        } else if (state is FailedAuthorizationState) {
          stopButtonLoading?.call();
        } 
        // else if (state is AuthorizedState) {
        //   Wrapper.openOnly(context);
        // }
      },
      child: PrimaryButton(
        label: "Sign up".toUpperCase(),
        textColor: AppColors.darkGreyColor,
        buttonHeight: 60,
        isArgon: true,
        onArgonTap: (startLoading, stopLoading, buttonState) async {
          startButtonLoading ??= startLoading;
          stopButtonLoading ??= stopLoading;
          _onSignUpBtnTap(context);
        },
      ),
    );
  }

  void _onSignUpBtnTap(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(SignUpEvent(
        finCode: _finCodeController.text.trim().toUpperCase(),
        phoneNumber: formatPhoneNumberWithPrefix(_phoneNumberController.text.trim()),
        password: _passwordController.text.trim(),
      ));
    }
  }

  String _buildBetterSignInText() {
    return "Already have an account? Sign In!";
  }

  void _onBetterSignInBtnTap(BuildContext context) {
    context.pop(context);
  }
}