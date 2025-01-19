import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:momentum/api/api_routes.dart';
class Api  {
  static Future<http.Response> get(String url) async {
    String fullUrl = ApiRoutes.baseUrl + url;
    return await http.get(Uri.parse(fullUrl),headers: {'Content-Type': 'application/json'});
  }
  static Future<http.Response> post(String url, Map<String, dynamic> body) async {
    String fullUrl = ApiRoutes.baseUrl + url;
    return await http.post(Uri.parse(fullUrl), body: jsonEncode(body), headers: {'Content-Type': 'application/json','Accept': 'application/json'});
  }
}