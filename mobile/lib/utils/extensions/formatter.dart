import 'package:pasha_insurance/constants/strings/app_consts.dart';

extension Formatter on dynamic { 

  String formatPhoneNumberWithPrefix(String fullPhoneNumber) {
    final String prefix = fullPhoneNumber.substring(6, 8);
    final String phoneNumber = prefix + fullPhoneNumber.substring(10).replaceAll("-", "");
    return phoneNumber;
  }

  String formatRawPhoneNumber(String rawPhoneNumber) {
    final String maskedString = AppConsts.phoneNumberMask.replaceAllMapped(RegExp(r'#'), (match) {
      if (rawPhoneNumber.isEmpty) {
        return match.group(0)!;
      } else {
        final digit = rawPhoneNumber[0];
        rawPhoneNumber = rawPhoneNumber.substring(1);
        return digit;
      }
    });
    return maskedString;
  }
}