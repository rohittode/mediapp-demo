class PasswordValidator {
  static bool validatePassword(String password) {
    // Password should contain at least 1 special character, numbers,
    // 1 capital, and 1 lowercase letter, and have a minimum length of 6 characters
    RegExp passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$',
    );
    return passwordRegExp.hasMatch(password);
  }
}
