import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yogaapp/constents/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogaapp/model/lession_model.dart';

import '../model/session_model.dart';

Future<void> createSession(
    String title, String instructor, String category, String image) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  if (token == null) {
    print('Token not found in shared preferences');
    return;
  }

  final url = Uri.parse('$baseUrl/v1/session');
  final response = await http.post(
    url,
    body: jsonEncode({
      'title': title,
      'instructor': instructor,
      'category': category,
      'image': image,
    }),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    print('Session created successfully');
  } else {
    print('Failed to create session. Error: ${response.body}');
  }
}

Future<List<Lesson>> fetchLessons() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final url = Uri.parse('$baseUrl/v1/lessons');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> lessionJsonList = jsonDecode(response.body);
    final List<Lesson> lessions =
        lessionJsonList.map((json) => Lesson.fromJson(json)).toList();
    print(lessions.length);
    return lessions;
  } else {
    throw Exception('Failed to fetch lessons. Error: ${response.body}');
  }
}

Future<List<Session>> fetchSession() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final url = Uri.parse('$baseUrl/v1/sessions');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> sessionJsonList = jsonDecode(response.body);
    final List<Session> sessions =
        sessionJsonList.map((json) => Session.fromJson(json)).toList();
    print(sessions.length);
    return sessions;
  } else {
    throw Exception('Failed to fetch lessons. Error: ${response.body}');
  }
}

Future<Lesson> fetchSingleLessons(String id) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final url = Uri.parse('$baseUrl/v1/lessons/?id=$id');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final lessonsJson = jsonDecode(response.body);
    final lession = Lesson.fromJson(lessonsJson);
    return lession;
  } else {
    throw Exception('Failed to fetch lessons. Error: ${response.body}');
  }
}

Future<Session> fetchSingleSession(String sessionId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('$baseUrl/v1/session/?id=$sessionId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Session fetched successfully
      final sessionJson = jsonDecode(response.body);
      final session = Session.fromJson(sessionJson);
      return session;
    } else {
      // Failed to fetch session
      throw Exception('Failed to fetch session. Error: ${response.body}');
    }
  } catch (e) {
    throw Exception(e);
  }
}
