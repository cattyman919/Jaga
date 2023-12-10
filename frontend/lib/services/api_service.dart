import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/app/app.dialogs.dart';
import 'package:frontend/app/app.locator.dart';
import 'package:frontend/models/user.model.dart';
import 'package:frontend/models/vehicle.model.dart';
import 'package:frontend/models/vehicleModel.model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final storage = const FlutterSecureStorage();
  final _dialogService = locator<DialogService>();
  final localhostIP = "http://192.168.137.1:3000";
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
      final user =
          User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return user;
    } catch (e) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error, description: '${e}');
      throw new HttpException("${e}");
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
      return vehicleModelsList;
    } catch (e) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error, description: '${e}');
      rethrow;
    }
  }

  Future<List<Vehicle>> getUserVehicles(int userID) async {
    try {
      List<Vehicle> vehiclesList = [];
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) throw new Exception("Token has expired");

      final response = await http
          .get(Uri.parse('$currentURL/vehicles/user-id/${userID}'), headers: {
        "Authorization": 'Bearer ${accessToken}'
      }).timeout(timeoutDuration);
      final body = jsonDecode(response.body);
      for (var i = 0; i < body.length; i++) {
        var vehicle = Vehicle.fromJson(body[i] as Map<String, dynamic>);

        vehiclesList.add(vehicle);
      }
      return vehiclesList;
    } catch (e) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error, description: '${e}');
      rethrow;
    }
  }

  Future<Vehicle> getVehicleID(int vehicleID) async {
    try {
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) throw new Exception("Token has expired");

      final response = await http
          .get(Uri.parse('$currentURL/vehicles/${vehicleID}'), headers: {
        "Authorization": 'Bearer ${accessToken}'
      }).timeout(timeoutDuration);
      final body = jsonDecode(response.body);
      var vehicle = Vehicle.fromJson(body as Map<String, dynamic>);

      return vehicle;
    } catch (e) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error, description: '${e}');
      rethrow;
    }
  }
}
