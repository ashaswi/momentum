import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:momentum/api/api_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Api  {
  static Future<http.Response> get(String url) async {
    String fullUrl = ApiRoutes.baseUrl + url;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return await http.get(Uri.parse(fullUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    });
  }
   static Future<http.Response> post(
      String url, Map<String, dynamic> body) async {
    String fullUrl = ApiRoutes.baseUrl + url;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return await http
        .post(Uri.parse(fullUrl), body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token'
    });
    
  }
}