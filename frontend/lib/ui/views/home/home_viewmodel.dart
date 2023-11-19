import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:frontend/app/app.bottomsheets.dart';
import 'package:frontend/app/app.dialogs.dart';
import 'package:frontend/app/app.locator.dart';
import 'package:frontend/ui/common/app_strings.dart';
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
  final List<CarModelService> _carModelServices = [
    CarModelService(carName: 'Avanza', kmDistance: 300, timeDuration: 2),
    CarModelService(carName: 'BMW M3', kmDistance: 1512, timeDuration: 5),
  ];

  List<CarModelService> get carModelServices => _carModelServices;

  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  void bluetoothInit() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    var lol = await NetworkInterface.list();
    print(lol);
    var oof = await flutterBlue.isAvailable;
    print(oof);
  }

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
