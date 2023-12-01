import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/app/app.locator.dart';
import 'package:frontend/models/user.model.dart';
import 'package:frontend/models/vehicleModel.model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final storage = const FlutterSecureStorage();
  final _dialogService = locator<DialogService>();
  final localhostIP = "http://192.168.56.101:3000";
  final deployURL = "https://jaga-backend.vercel.app";

  String get currentURL => localhostIP;


  final Duration timeoutDuration = const Duration(seconds: 15);

  Future<User> profile() async {
    try {
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) throw new Exception("Token has expired");
      final response = await http.get(Uri.parse('$currentURL/auth/profile'),
          headers: {
            "Authorization": 'Bearer ${accessToken}'
          }).timeout(timeoutDuration);
      final user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<VehicleModel>> getAllVehicleModels() async {
    try {
      List<VehicleModel> vehicleModelsList = [];
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) throw new Exception("Token has expired");

      final response = await http.get(Uri.parse('$currentURL/vehicle-models'),
          headers: {
            "Authorization": 'Bearer ${accessToken}'
          }).timeout(timeoutDuration);
      final body = jsonDecode(response.body);

      for (var i = 0; i < body.length; i++) {
        var vehicleModel =
            VehicleModel.fromJson(body[i] as Map<String, dynamic>);

        vehicleModelsList.add(vehicleModel);
      }
      print(vehicleModelsList[1]);
      return vehicleModelsList;
    } catch (e) {
      rethrow;
    }
  }
}
