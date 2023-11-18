class AppConsts {
  AppConsts._();

  static const String phoneNumberCountryCode = '+994';
  static const String phoneNumberMask = '$phoneNumberCountryCode (##) ###-##-##';
  static const List<int> phoneNumberPrefixes = [10, 50, 51, 60, 70, 77, 99, 55];

  // static MaskTextInputFormatter get phoneNumInputFormatter => MaskTextInputFormatter(
  //       mask: phoneNumberMask,
  //       filter: {"#": RegExp(r'[0-9]')},
  //       // initialText: initialText != AppConsts.phoneNumberCountryCode ? initialText : null,
  //     );
}
