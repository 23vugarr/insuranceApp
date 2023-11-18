import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final FocusNode? focusNode;
  final bool disabled;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String val)? onFieldSubmitted;
  final Color? titleTextColor;
  final bool obscureText;
  final bool includeObscureTextIcon;

  const AuthTextField({super.key,
    required this.controller,
    required this.title,
    this.focusNode,
    this.disabled = false,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.hintText,
    this.maxLength,
    this.onTap,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.sentences, 
    this.titleTextColor,
    this.obscureText = false, 
    this.includeObscureTextIcon = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _isTextObscured;

  @override
  void initState() {
    super.initState();
    _isTextObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUpperPart(),
        _buildTextField(context),
      ],
    );
  }

  Widget _buildUpperPart() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 4),
        child: Text(widget.title, style: AppTextStyles.captionSize12.copyWith(color: widget.titleTextColor ?? AppColors.darkGreyColor)),
      )
    );
  }

  Widget _buildTextField(BuildContext context) {
    const TextStyle defaultTextStyle = AppTextStyles.body2Size14;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          enabled: !widget.disabled,
          obscureText: _isTextObscured,
          textInputAction: widget.textInputAction,
          maxLength: widget.maxLength,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.textCapitalization,
          style: defaultTextStyle,
          decoration: InputDecoration(
            errorStyle: defaultTextStyle.copyWith(color: AppColors.red),
            hintStyle: defaultTextStyle.copyWith(color: AppColors.greyTextColor2),
            hintText: widget.hintText,
            fillColor: AppColors.white.withOpacity(0.6),
            filled: true,
            counterText: "",
            border: defaultBorder,
            enabledBorder: defaultBorder,
            disabledBorder: defaultBorder,
            focusedBorder: defaultBorder,
            errorBorder: errorBorder(context),
            focusedErrorBorder: errorBorder(context),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            suffixIconColor: AppColors.lightGreyColor,
            suffixIcon: widget.includeObscureTextIcon
              ? IconButton(
                onPressed: () {
                  setState(() {
                    _isTextObscured = !_isTextObscured;
                  });
                }, 
                splashColor: Colors.transparent,
                icon: Icon(_isTextObscured ? Icons.visibility_rounded : Icons.visibility_off_rounded)
              ) 
              : null
          ),
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
    );
  }

  InputBorder get defaultBorder => OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.transparent)); 

  InputBorder errorBorder(BuildContext context) => OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color:AppColors.red)); 
}