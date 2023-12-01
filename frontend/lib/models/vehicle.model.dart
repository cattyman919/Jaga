class Vehicle {
  final String name;
  final String model_id;
  final String type;
  final DateTime years;
  final int kilometres;

  Vehicle(this.name, this.model_id, this.type, this.years, this.kilometres);

  Vehicle.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        model_id = json["model_id"] as String,
        type = json["model_id"] as String,
        years = json["model_id"] as DateTime,
        kilometres = json["kilometres"] as int;

  Map<String, dynamic> toJson() => {
        'name': name,
        'model_id': model_id,
        'type': type,
        'years': years,
        'kilometres': kilometres,
      };
}
