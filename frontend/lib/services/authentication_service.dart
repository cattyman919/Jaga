import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/app/app.locator.dart';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';

class AuthenticationService {
  final storage = const FlutterSecureStorage();
  final _dialogService = locator<DialogService>();
  final localhostIP = "http://192.168.1.18:3000";
  final localhostIPAndroid = 'http://10.0.2.2:3000';
  final deployURL = "https://jaga-backend.vercel.app";

  String get currentIP => localhostIPAndroid;

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${deployURL}/auth/login'),
        body: {
          'email': email,
          'password': password,
        },
      ).timeout(const Duration(seconds: 8));

      final responseJson = json.decode(response.body);
      if (response.statusCode == 201) {
        await storage.write(
          key: 'access_token',
          value: responseJson['accessToken'],
        );
        await storage.write(
          key: 'refresh_token',
          value: responseJson['refreshToken'],
        );
      } else {
        throw Exception('Wrong Credentials');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${deployURL}/auth/register'),
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 201) return;

      final responseJson = json.decode(response.body);

      if (response.statusCode == 400) {
        throw responseJson['message'];
      } else
        throw "Failed to create account";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }

  Future<bool> isLoggedIn() async {
    final access_token = await storage.read(key: 'access_token');
    final refresh_token = await storage.read(key: 'refresh_token');

    return (access_token != null && refresh_token != null);
  }

  bool userLoggedIn() {
    return false;
  }
}
