import 'package:frontend/models/vehicleModel.model.dart';

class Vehicle {
  final int id;
  final int userID;
  final int model_id;
  final String type;
  final DateTime date;
  final int kilometres;
  final VehicleModel vehicleModel;

  Vehicle(this.id, this.userID, this.model_id, this.type, this.date,
      this.kilometres, this.vehicleModel);

  Vehicle.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        userID = json["userID"] as int,
        model_id = json["model_id"] as int,
        type = json["type"] as String,
        date = DateTime.parse(json['date']),
        kilometres = json["kilometres"] as int,
        vehicleModel = VehicleModel.fromJson(json["vehicleModel"]);

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'model_id': model_id,
        'type': type,
        'date': date,
        'kilometres': kilometres,
      };
}
