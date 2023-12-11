class VehicleModel {
  final int id;
  final String model_name;
  final String image_path;

  VehicleModel(this.id,this.model_name, this.image_path);

  VehicleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        model_name = json["model_name"] as String,
        image_path = json["image_path"] as String;

  Map<String, dynamic> toJson() => {
        'model_name': model_name,
        'image_path': image_path,
      };
}
