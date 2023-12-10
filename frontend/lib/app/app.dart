import 'package:frontend/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:frontend/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:frontend/ui/views/home/home_view.dart';
import 'package:frontend/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:frontend/ui/views/login/login_view.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/ui/views/signup/signup_view.dart';
import 'package:frontend/ui/dialogs/error/error_dialog.dart';
import 'package:frontend/ui/dialogs/success/success_dialog.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/ui/views/detail_cars/detail_cars_view.dart';
import 'package:frontend/ui/dialogs/new_car/new_car_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: DetailCarsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: ApiService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ErrorDialog),
    StackedDialog(classType: SuccessDialog),
    StackedDialog(classType: NewCarDialog),
// @stacked-dialog
  ],
)
class App {}
