import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  final storage = const FlutterSecureStorage();

  Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.101:3000/auth/login'),
        body: {
          'email': username,
          'password': password,
        },
      );

      final responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        await storage.write(
          key: 'access_token',
          value: responseJson['access_token'],
        );
        await storage.write(
          key: 'refresh_token',
          value: responseJson['refresh_token'],
        );
      } else {
        throw Exception('Failed to authenticate');
      }
    } catch (e) {
      print('Bruh : ${e}');
      throw Exception('Failed to authenticate');
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }

  bool userLoggedIn() {
    return false;
  }
}
