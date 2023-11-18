import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/style/animation_consts.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/ui/widgets/custom/argon_button.dart';
import 'package:pasha_insurance/ui/widgets/custom/scale_animated_widget.dart';

class PrimaryButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String? label;
  final Widget? trailingWidget;
  final Widget? leadingWidget;
  final void Function()? onTap;
  final Color? borderColor;
  final MainAxisAlignment mainAxisAlignment;
  final double buttonHeight;
  final double? buttonWidth;
  final bool occupyMinWidth;
  final RichText? richText;
  final bool isCircular;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final List<BoxShadow>? buttonShadow;
  final Duration? labelAnimDuration;
  final bool isArgon;
  final dynamic Function(Function startLoading, Function stopLoading, ButtonState buttonState)? onArgonTap;

  PrimaryButton({super.key,
    this.label,
    this.color,
    this.textColor,
    this.trailingWidget,
    this.onTap,
    this.leadingWidget,
    this.borderColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.buttonHeight = 60,
    this.buttonWidth,
    this.buttonShadow,
    this.richText,
    this.occupyMinWidth = false,
    this.isCircular = false,
    this.child,
    this.padding,
    this.contentPadding,
    this.labelAnimDuration,

    this.isArgon = false,
    this.onArgonTap
  });

  final GlobalKey<ArgonButtonState> _argonButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (isArgon) {
      return _buildArgonButton(context);
    }
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ScaleAnimatedWidget(
        onPressed: onTap,
        child: Container(
          padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 70),
          width: occupyMinWidth ? null : buttonWidth ?? MediaQuery.of(context).size.width,
          height: buttonHeight,
          decoration: BoxDecoration(
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            color: color ?? AppColors.secondary,
            borderRadius: !isCircular ? BorderRadius.circular(20) : null,
            border: Border.all(
              color: borderColor == null ? Colors.transparent : borderColor!,
            ),
            boxShadow: buttonShadow,
          ),
          child: _buildButtonChild()
        ),
      ),
    );
  }

  Widget _buildButtonChild() {
    return child != null
          ? Center(child: child)
          : leadingWidget != null
            ? Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                leadingWidget != null ? leadingWidget! : const SizedBox(),
                _buildText(),
                trailingWidget != null ? trailingWidget! : const SizedBox(),
              ],
            )
            : trailingWidget != null
              ? Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  _buildText(),
                  trailingWidget != null ? trailingWidget! : const SizedBox(),
                ],
              )
              : Center(
                child: _buildText(),
              );
  }

  Widget _buildArgonButton(BuildContext context) {
    return ArgonButton(
      key: _argonButtonKey,
      height: buttonHeight,
      width: buttonWidth ?? MediaQuery.of(context).size.width,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      color: color ?? AppColors.secondary,
      focusColor: color ?? AppColors.secondary,
      disabledColor: color ?? AppColors.secondary,
      hoverColor: color ?? AppColors.secondary,
      splashColor: color ?? AppColors.secondary,
      highlightColor: color ?? AppColors.secondary,
      borderRadius: !isCircular ? 20 : 0.0,
      curve: AnimationConsts.kAppAnimCurve,
      loader: const CircularProgressIndicator(color: AppColors.white),
      padding: padding ?? EdgeInsets.zero,
      onTap: onArgonTap,
      child: _buildButtonChild(),
    );
  }
  
  Widget _buildText() {
    return richText != null
      ? richText!
      : label != null
        ? labelAnimDuration != null
            ? AnimatedSwitcher(
              duration: labelAnimDuration!,
              child: Text(
                key: ValueKey<String>(label!),
                label!,
                textAlign: TextAlign.center,
                style: AppTextStyles.buttonSize14.copyWith(color: textColor),
              ),
            )
            : Text(
              label!,
              textAlign: TextAlign.center,
              style: AppTextStyles.buttonSize14.copyWith(color: textColor),
            )
        : const SizedBox();
  }
}