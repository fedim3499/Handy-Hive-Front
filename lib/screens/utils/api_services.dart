import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_front/auth_dto.dart'; // Import the AuthDto class from the backend

class ApiService {
  static const String baseUrl = 'http://http://localhost:5032/api/auth/register';

  Future<String> signIn(AuthDto authDto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': authDto.email,
        'Password': authDto.password,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to sign in: ${response.body}');
    }
  }

  Future<String> signUp(AuthDto authDto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(authDto.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  Future<String> refreshToken(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/refresh-token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'refreshToken': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to refresh token: ${response.body}');
    }
  }
}
