import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:yogaapp/constents/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogaapp/provider/register_provider.dart';

Future<bool> registerUser(
    String username, String email, String gender, String password) async {
  try {
    final url = Uri.parse('$baseUrl/v1/auth/register');
    final response = await http.post(
      url,
      body: jsonEncode({
        'username': username,
        'email': email,
        'gender': gender,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // User created successfully
      print('User created successfully ${response.body}');
      final token = jsonDecode(response.body)['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return true;
    } else {
      print('Failed to create user. Error: ${response.body}');

      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> loginUser(String email, String password) async {
  try {
    final url = Uri.parse('$baseUrl/v1/auth/login');
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Login successful, handle the response accordingly
      final token = jsonDecode(response.body)['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('Login successful');
      print('Token: ${jsonDecode(response.body)['token']}');
      print(response.body);
      return true;
    } else {
      // Login failed
      print('Login failed. Error: ${response.body}');
      return true;
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> logoutUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  print('Logged out');
}
