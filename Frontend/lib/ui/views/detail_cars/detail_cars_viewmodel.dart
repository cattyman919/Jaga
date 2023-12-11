import 'package:frontend/app/app.locator.dart';
import 'package:frontend/models/service.model.dart';
import 'package:frontend/models/vehicle.model.dart';
import 'package:frontend/services/api_service.dart';
import 'package:stacked/stacked.dart';

class DetailCarsViewModel extends BaseViewModel {
  final int idVehicle;
  DetailCarsViewModel(this.idVehicle);

  final _APIService = locator<ApiService>();
  late final Vehicle vehicle;

  List<ServiceItem> services = [
    ServiceItem(
        name: 'Brake Canvas',
        nextServiceAt: 'Overdue! Go to service immediately.',
        type: ServiceType.overdue),
    ServiceItem(
        name: 'Oil Filter',
        nextServiceAt: 'Next Replacement in next 300 Km or 2 months',
        type: ServiceType.upcoming),
    ServiceItem(
        name: 'AC Filter',
        nextServiceAt: 'Changed on 23441 Km on 21/08/2023',
        type: ServiceType.upcoming),
  ];

  void init() async {
    setBusy(true);
    vehicle = await _APIService.getVehicleID(idVehicle);
    setBusy(false);
  }
}
