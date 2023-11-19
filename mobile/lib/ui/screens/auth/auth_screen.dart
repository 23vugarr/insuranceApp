import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasha_insurance/constants/strings/assets.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/models/enum/awareness_level.dart';
import 'package:pasha_insurance/states/bloc/auth/auth_bloc.dart';
import 'package:pasha_insurance/ui/widgets/helpers/empty_space.dart';
import 'package:pasha_insurance/utils/helpers/app_loger.dart';
import 'package:pasha_insurance/utils/toast_notifier.dart';

abstract class AuthScreen extends StatefulWidget {
  Form buildForm();
  Widget buildButton(BuildContext context);
  String getSuggestionText();
  void onSuggestionTap(BuildContext context);
  bool isAloneInNavTree() => true;

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.forthType,
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (_, current) => current is FailedAuthorizationState,
        listener: (context, state) {
          if (!widget.isAloneInNavTree())  return;  // prevents multiple listener calls
          logger.i("Authorization failure occured}");
          ToastNotifier.showToast(message: "There is no account with given credentials.", awarenessLevel: AwarenessLevel.ERROR);
        },
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 56),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 2),
            _buildLogo(),
            const Spacer(flex: 1),
            widget.buildForm(),
            EmptySpace.vertical(24),
            widget.buildButton(context),
            const Spacer(flex: 2),
            buildClickableSuggestionText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    const double logoSize = 72;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ 
        Image.asset(Assets.appLogo, height: logoSize, width: logoSize),
        EmptySpace.horizontal(16),
        Text("Pasha\nProtectors", style: AppTextStyles.headline1Size24.copyWith(fontSize: 32, height: 1)),
      ],
    );
  }

  GestureDetector buildClickableSuggestionText(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSuggestionTap(context),
      child: Text(widget.getSuggestionText(),
      style: AppTextStyles.underlineBody2Size14.copyWith(color: AppColors.primary)
      )
    );
  }
}
