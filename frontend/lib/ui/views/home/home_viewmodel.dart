import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:frontend/app/app.bottomsheets.dart';
import 'package:frontend/app/app.dialogs.dart';
import 'package:frontend/app/app.locator.dart';
import 'package:frontend/app/app.router.dart';
import 'package:frontend/models/user.model.dart';
import 'package:frontend/models/vehicle.model.dart';
import 'package:frontend/models/vehicleModel.model.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/ui/common/app_strings.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CarModelService extends ChangeNotifier {
  final String carName;
  final int kmDistance;
  final int timeDuration;

  CarModelService(
      {required this.carName,
      required this.kmDistance,
      required this.timeDuration});
}

class HomeViewModel extends IndexTrackingViewModel {
  final _APIService = locator<ApiService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  final FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  late final List<BluetoothDiscoveryResult> _devicesList = [];
  List<BluetoothDiscoveryResult> get deviceList => _devicesList;

  BluetoothDevice? _device;
  bool _connected = false;
  bool _scanningBluetooth = false;
  bool get scanningBluetooth => _scanningBluetooth;

  BluetoothConnection? connection;

  final List<CarModelService> _carModelServices = [
    CarModelService(carName: 'Avanza', kmDistance: 300, timeDuration: 2),
    CarModelService(carName: 'BMW M3', kmDistance: 1512, timeDuration: 5),
    CarModelService(carName: 'BMW M3', kmDistance: 1512, timeDuration: 5),
    CarModelService(carName: 'BMW M3', kmDistance: 1512, timeDuration: 5),
    CarModelService(carName: 'BMW M3', kmDistance: 1512, timeDuration: 5),
    CarModelService(carName: 'BMW M3', kmDistance: 1512, timeDuration: 5),
    CarModelService(carName: 'BMW M3', kmDistance: 1512, timeDuration: 5),
    CarModelService(carName: 'BMW M3', kmDistance: 1512, timeDuration: 5),
  ];

  List<CarModelService> get carModelServices => _carModelServices;

  String get counterLabel => 'Counter is: $_counter';

  final pageViewController = PageController();

  int activePage = 0;

  int _counter = 0;

  late final bluetoothIsAvailable;

  late final User user;

  late final List<Vehicle> vehicles;

  void init() async {
    setBusy(true);
    user = await _APIService.profile();
    vehicles = await _APIService.getUserVehicles(user.id);
    setBusy(false);
  }

  void bluetoothInit() async {
    // if (await FlutterBluePlus.isSupported == false) {
    //   print("Bluetooth not supported by this device");
    //   bluetoothIsAvailable = false;
    //   await _dialogService.showCustomDialog(
    //       variant: DialogType.error,
    //       title: "damn you don't have a Bluetooth very sad",
    //       description: "You cannot connect and claim your ESP32");
    //   return;
    // }

    // bluetoothIsAvailable = true;
    // await _dialogService.showCustomDialog(
    //     variant: DialogType.success,
    //     title: "Hooray you have a Bluetooth",
    //     description: "You can use this to connect and claim your ESP32");
  }

  void updateData() async {
    setBusy(true);
    vehicles.clear();
    var vehicleData = await _APIService.getUserVehicles(user.id);
    vehicles.addAll(vehicleData);
    setBusy(false);
  }

  void onRefresh() async {
    updateData();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onPageChanged(int indexPage) async {
    await bluetooth.cancelDiscovery();
    print(indexPage);
    print("Current index" + currentIndex.toString());
  }

  Future<void> bluetoothScan() async {
    _devicesList.clear();
    setBusyForObject(_scanningBluetooth, false);
    bluetooth.startDiscovery().listen((r) {
      // Handle discovery results

      if (r.device.name != null &&
          r.device.type == BluetoothDeviceType.classic) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        _devicesList.add(r);
      }

      notifyListeners();
    }).onDone(() {
      setBusyForObject(_scanningBluetooth, false);

      // Handle when discovery is done
    });
  }

  Future<void> bluetoothConnect(BluetoothDiscoveryResult device) async {
    await Future.delayed(Duration(seconds: 3));
    await _dialogService.showCustomDialog(
        variant: DialogType.success,
        description: "Bluetooth Connection Successful");
  }

  void logOutUser() async {
    try {
      print("Logout");
      await _authenticationService.logout();
      print("Finished Logout");
      setBusy(false);
      _dialogService
          .showCustomDialog(
              variant: DialogType.success, description: "Logout Successful")
          .whenComplete(_navigationService.replaceWithLoginView);
    } catch (e) {
      setBusy(false);
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: '$e',
      );
    }
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  void navigateToCarDetails(int idVehicle) {
    _navigationService.navigateToDetailCarsView(idVehicle: idVehicle);
  }

  void showCreateCarsDialog() async {
    if ((await _dialogService.showCustomDialog(
            variant: DialogType.newCar, data: user.id))!
        .confirmed) {
      updateData();
    }
  }

  Future<bool> onBackPressed() async {
    bool? canPop = StackedService.navigatorKey?.currentState?.canPop();

    // Check if we can't pop back stack. If we can't it means we will pop out from app
    if (!canPop!) {
      Set<bool> popFromApp = await _dialogService
          .showConfirmationDialog(
              title: "Are you sure you want to exit the app?")
          .then((value) => {if (value!.confirmed) true else false});

      return popFromApp.first;
    } else {
      Set<bool> logout = await _dialogService
          .showConfirmationDialog(title: "Are you sure you want to logout?")
          .then((value) => {if (value!.confirmed) true else false});
      if (logout.first) {
        await _authenticationService.logout();
        return true;
      }
      return false;
    }
  }
}
