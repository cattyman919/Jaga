import 'package:frontend/models/service.model.dart';
import 'package:frontend/models/vehicleModel.model.dart';

class Vehicle {
  final int id;
  final int userID;
  final int model_id;
  final String type;
  final DateTime date;
  final int kilometres;
  final VehicleModel vehicleModel;
  final List<ServiceItem> services;

  Vehicle(this.id, this.userID, this.model_id, this.type, this.date,
      this.kilometres, this.vehicleModel, this.services);

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    var list = json["services"] as List;
    List<ServiceItem> serviceList =
        list.map((i) => ServiceItem.fromJson(i)).toList();

    return Vehicle(
      json['id'] as int,
      json["userID"] as int,
      json["model_id"] as int,
      json["type"] as String,
      DateTime.parse(json['date']),
      json["kilometres"] as int,
      VehicleModel.fromJson(json["vehicleModel"]),
      serviceList,
    );
  }

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'model_id': model_id,
        'type': type,
        'date': date,
        'kilometres': kilometres,
      };
}
