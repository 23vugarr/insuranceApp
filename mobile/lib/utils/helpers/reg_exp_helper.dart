class RegExpHelper {
  RegExpHelper._();

  static const String passwordValidation = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
  static const String digitsValidation = r'[0-9]';
  static const String digitsAndLatinLettersValidation = r'[a-zA-Z0-9]';
}