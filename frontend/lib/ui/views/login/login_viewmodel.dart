import 'package:frontend/app/app.locator.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/ui/views/login/login_view.form.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();

  void loginUser() async {
    setBusy(true);
    try {
      _authenticationService.login(emailValue!, passwordValue!);
      setBusy(false);
    } catch (e) {
      setBusy(false);
      print('Error: $e');
    }
  }
}

class TextLoginValidators {
  static String? validateEmail(String? value) {
    RegExp regexEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null) {
      return null;
    }

    if (!regexEmail.hasMatch(value)) {
      return 'Invalid Email';
    }
    return value;
  }

  static String? validatePassword(String? value) {
    RegExp regexPassword =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (value == null) {
      return null;
    }

    if (!regexPassword.hasMatch(value)) {
      return 'Invalid password';
    }
    return value;
  }
}
