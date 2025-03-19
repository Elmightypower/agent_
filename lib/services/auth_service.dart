import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String apiUrl = "https://shipr.ggsdrc.com/index.php/api/agent/login"; // Replace with your API URL

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == true) {
          // Save user data to SharedPreferences
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('agent_id', data['user']['agent_id']);
          prefs.setString('nom_complet_agent', data['user']['nom_complet_agent']);
          prefs.setString('email_agent', data['user']['email_agent']);
          prefs.setString('adresse_physique', data['user']['adresse_physique']);
          prefs.setString('contact_agent', data['user']['contact_agent']);
          prefs.setString('ville', data['user']['ville']);
        }
        return data;
      } else {
        return {'status': false, 'message': 'Server error. Please try again.'};
      }
    } catch (e) {
      return {'status': false, 'message': 'An error occurred. Check your connection.'};
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear session data
  }

  Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'agent_id': prefs.getString('agent_id'),
      'nom_complet_agent': prefs.getString('nom_complet_agent'),
      'email_agent': prefs.getString('email_agent'),
      'adresse_physique': prefs.getString('adresse_physique'),
      'contact_agent': prefs.getString('contact_agent'),
      'pays': prefs.getString('pays'),
    };
  }
}
