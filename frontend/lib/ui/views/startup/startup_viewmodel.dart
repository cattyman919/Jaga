import 'package:frontend/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:frontend/app/app.locator.dart';
import 'package:frontend/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  // 1. Get the Authentication and NavigationService
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  Future runStartupLogic() async {
    // 2. Check if the user is logged in
    if (await _authenticationService.isLoggedIn()) {
      // 3. Navigate to Sign up View
      _navigationService.replaceWith(Routes.loginView);
    } else {
      // 4. Or navigate to Login View
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
