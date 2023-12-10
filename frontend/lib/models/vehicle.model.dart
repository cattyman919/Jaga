import 'package:frontend/models/vehicleModel.model.dart';

class Vehicle {
  final int id;
  final String name;
  final int model_id;
  final String type;
  final DateTime years;
  final int kilometres;
  final VehicleModel vehicleModel;

  Vehicle(this.id, this.name, this.model_id, this.type, this.years,
      this.kilometres, this.vehicleModel);

  Vehicle.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json["name"] as String,
        model_id = json["model_id"] as int,
        type = json["type"] as String,
        years = DateTime.parse(json['years']),
        kilometres = json["kilometres"] as int,
        vehicleModel = VehicleModel.fromJson(json["vehicleModel"]);

  Map<String, dynamic> toJson() => {
        'name': name,
        'model_id': model_id,
        'type': type,
        'years': years,
        'kilometres': kilometres,
      };
}
