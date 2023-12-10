class ServiceItem {
  final String name;
  final String nextServiceAt;
  final String type;

  ServiceItem(
      {required this.name, required this.nextServiceAt, required this.type});
}

class ServiceType {
  static String get upcoming => "upcoming";
  static String get overdue => "overdue";
}
