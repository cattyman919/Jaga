import 'package:flutter/animation.dart';
import 'package:frontend/app/app.dialogs.dart';
import 'package:frontend/app/app.locator.dart';
import 'package:frontend/app/app.router.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/ui/views/home/home_view.dart';
import 'package:frontend/ui/views/login/login_view.form.dart';
import 'package:frontend/ui/views/signup/signup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  init() {
    print("Init Login");
    emailValue = "admin@admin.com";
    passwordValue = "admin123";
    print(emailValue);
  }

  void loginUser() async {
    setBusy(true);
    try {
      print("Login");
      await _authenticationService.login(emailValue!, passwordValue!);
      print("Finished Login");
      //clearForm();
      setBusy(false);
      _dialogService
          .showCustomDialog(
              variant: DialogType.success, description: "Login Successful")
          .whenComplete(goToHomePage);
    } catch (e) {
      setBusy(false);
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: '$e',
      );
    }
  }

  void goToSignUp() async {
    await _navigationService.navigateWithTransition(const SignupView(),
        transitionStyle: Transition.downToUp,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        routeName: Routes.signupView);
  }

  void goToHomePage() async {
    await _navigationService.navigateWithTransition(const HomeView(),
        transitionStyle: Transition.rightToLeft,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        routeName: Routes.homeView);
  }

  Future<bool> onBackPressed() async {
    bool? canPop = StackedService.navigatorKey?.currentState?.canPop();

    // Check if we can't pop back stack. If we can't it means we will pop out from app
    if (!canPop!) {
      Set<bool> popFromApp = await _dialogService
          .showConfirmationDialog(
              title: "Are you sure you want to exit the app")
          .then((value) => {if (value!.confirmed) true else false});

      return popFromApp.first;
    } else {
      return false;
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
