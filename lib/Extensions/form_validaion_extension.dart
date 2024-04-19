extension ExtString on String? {
  bool get isNotNull {
    return this!.isNotEmpty;
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this!);
  }

  // bool get isValidPassword {
  //   final passwordRegExp =
  //       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  //   return passwordRegExp.hasMatch(this!);
  // }
}
