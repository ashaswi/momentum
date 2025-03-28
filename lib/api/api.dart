import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:momentum/api/api_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static Future<http.Response> get(String url, {Map<String,dynamic>? params}) async {
    String fullUrl = ApiRoutes.baseUrl + url;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return await http.get(Uri.parse(fullUrl).replace(queryParameters: params), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    });
  }

  static Future<http.Response> post(
      String url, Map<String, dynamic> body) async {
    String fullUrl = ApiRoutes.baseUrl + url;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add the Authorization header only if the token is not null
    if (token != null) {
      headers['Authorization'] = 'Token $token';
    }

    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(body),
      headers: headers,
    );
  }
   static Future<http.Response> put(
    String url, Map<String, dynamic> body) async {
    String fullUrl = ApiRoutes.baseUrl + url;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add the Authorization header only if the token is not null
    if (token != null) {
      headers['Authorization'] = 'Token $token';
    }

    return await http.put(
      Uri.parse(fullUrl),
      body: jsonEncode(body),
      headers: headers,
    );
  }
  static Future<http.Response> delete(
      String url) async {
    String fullUrl = ApiRoutes.baseUrl + url;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add the Authorization header only if the token is not null
    if (token != null) {
      headers['Authorization'] = 'Token $token';
    }

    return await http.delete(
      Uri.parse(fullUrl),
      headers: headers,
    );
  }
}