import 'package:frontend/app/app.locator.dart';
import 'package:frontend/app/app.router.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  void toLoginPage() async {
    _navigationService.replaceWithLoginView();
  }
}
