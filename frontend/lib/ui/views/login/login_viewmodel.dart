import 'package:frontend/app/app.locator.dart';
import 'package:frontend/app/app.router.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/ui/views/login/login_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  void loginUser() async {
    setBusy(true);
    try {
      print("Login");
      await _authenticationService.login(emailValue!, passwordValue!);
      await _authenticationService.isLoggedIn();
      print("Finished Login");
    } catch (e) {
      setBusy(false);
      print('Error: $e');
    }
  }

  void goToSignUp() async {
    _navigationService.replaceWithSignupView();
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
