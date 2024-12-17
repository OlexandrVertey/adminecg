import 'package:adminecg/common/shared_preference/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPageProvider extends ChangeNotifier {
  LoginPageProvider({
    required this.sharedPreference,
  });

  final SharedPreference sharedPreference;


  RegisterState state = RegisterState();

  RegExp passwordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  void loginButtonIsActive() {
    if (passwordValid.hasMatch(state.passwordController.text)
        && state.userNameController.text.length > 2) {
      state.loginButtonIsActive = true;
    } else {
      state.loginButtonIsActive = false;
    }
    notifyListeners();
  }
}

class RegisterState {
  bool loginButtonIsActive = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
