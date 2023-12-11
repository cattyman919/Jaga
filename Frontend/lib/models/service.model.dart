class ServiceItem {
  final int? id;
  final String title;
  final String description;
  final String type;

  ServiceItem(
      {this.id,
      required this.title,
      required this.description,
      required this.type});

  ServiceItem.fromJson(Map<String, dynamic> json)
      : id = json["id"] as int,
        title = json["title"] as String,
        description = json["description"] as String,
        type = json["type"] as String;
}

class ServiceType {
  static String get upcoming => "upcoming";
  static String get overdue => "overdue";
}
