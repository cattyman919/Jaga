import 'package:flutter/material.dart';
import 'package:frontend/app/app.dialogs.dart';
import 'package:frontend/app/app.locator.dart';
import 'package:frontend/app/app.router.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/ui/views/login/login_view.dart';
import 'package:frontend/ui/views/signup/signup_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  void toLoginPage() async {
    _navigationService.replaceWithTransition(const LoginView(),
        transitionStyle: Transition.upToDown,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        routeName: Routes.loginView);
  }

  void signUpUser() async {
    setBusy(true);
    try {
      print("Signing Up...");
      await _authenticationService.register(
          usernameValue!, emailValue!, passwordValue!);
      print("Finished Sign Up");
      clearForm();
      setBusy(false);
      _dialogService
          .showCustomDialog(
              variant: DialogType.success,
              description: "Account has successfully been created")
          .whenComplete(() => _navigationService.replaceWithLoginView());
    } catch (e) {
      setBusy(false);
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: '$e',
      );
    }
  }
}
