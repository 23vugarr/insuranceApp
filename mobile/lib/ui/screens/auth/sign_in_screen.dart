// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/states/bloc/auth/auth_bloc.dart';
import 'package:pasha_insurance/ui/screens/auth/auth_screen.dart';
import 'package:pasha_insurance/ui/screens/auth/sign_up_screen.dart';
import 'package:pasha_insurance/ui/widgets/buttons/primary_button.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';
import 'package:pasha_insurance/ui/widgets/text_fields/fin_code_text_field.dart';
import 'package:pasha_insurance/ui/widgets/text_fields/password_text_field.dart';

class SignInScreen extends AuthScreen {
  SignInScreen({Key? key}) : super(key: UniqueKey());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _finCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Function? startButtonLoading;
  Function? stopButtonLoading;

  @override
  Form buildForm() => _buildSignInForm();

  @override
  Widget buildButton(BuildContext context) => _buildSignInButton(context);

  @override
  String getSuggestionText() => _buildBetterSignUpText();

  @override
  void onSuggestionTap(BuildContext context) => _onBetterSignUpBtnTap(context);

  Form _buildSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FinCodeTextField(finCodeController: _finCodeController),
          EmptySpace.vertical(12),
          PasswordTextField(passwordController: _passwordController),
        ],
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is LoadingState || (current is FailedAuthorizationState && previous is LoadingState),
      listener: (context, state) {
        if (state is LoadingState) {
          startButtonLoading?.call();
        } else {
          stopButtonLoading?.call();
        }
      },
      child: PrimaryButton(
        label: "Sign in".toUpperCase(),
        textColor: AppColors.darkGreyColor,
        buttonHeight: 60,
        isArgon: true,
        onArgonTap: (startLoading, stopLoading, buttonState) async {
          startButtonLoading ??= startLoading;
          stopButtonLoading ??= stopLoading;
          _onSignInBtnTap(context);
        },
      ),
    );
  }

  String _buildBetterSignUpText() {
    return "Don't have an account? Sign Up!";
  }

  void _onBetterSignUpBtnTap(BuildContext context) {
    SignUpScreen.open(context);
  }

  void _onSignInBtnTap(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(SignInEvent(
        finCode: _finCodeController.text.trim().toUpperCase(),
        password: _passwordController.text.trim()
      ));
    }
  }
}