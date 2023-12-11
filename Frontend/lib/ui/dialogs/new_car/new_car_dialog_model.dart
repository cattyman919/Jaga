import 'package:flutter/material.dart';
import 'package:frontend/app/app.locator.dart';
import 'package:frontend/models/vehicleModel.model.dart';
import 'package:frontend/services/api_service.dart';
import 'package:stacked/stacked.dart';

class NewCarDialogModel extends BaseViewModel {
  final _APIService = locator<ApiService>();

  final TextEditingController vehicleModelOptions = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();

  late final List<VehicleModel> vehicleModels;
  late VehicleModel selectedVehicleModel;
  DateTime selectedDate = DateTime.now();

  void init() async {
    setBusy(true);
    vehicleModels = await _APIService.getAllVehicleModels();
    setBusy(false);
    selectedVehicleModel = vehicleModels[0];
    notifyListeners();
  }

  void setVehicleModel(String? value) async {
    selectedVehicleModel =
        vehicleModels.firstWhere((element) => element.model_name == value);
    notifyListeners();
  }

  void submitCreateNewCars(int userID) async {
    await _APIService.createVehicle(
        userID: userID, date: selectedDate, modelID: selectedVehicleModel.id);
  }
}
