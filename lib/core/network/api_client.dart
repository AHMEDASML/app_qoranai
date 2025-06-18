// lib/api/api_client.dart

import 'dart:convert';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:http/http.dart' as http;


class ApiClient {
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Authorization': 'application/json','Accept-Language':GlobalFunctions.getLangCode()!},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(endpoint),
      headers: {'Authorization': 'application/json','Accept-Language':GlobalFunctions.getLangCode()!},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(Uri.parse(endpoint));
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw Exception('Bad Request');
      case 401:
        throw Exception('Unauthorized');
      case 404:
        throw Exception('Not Found');
      case 500:
        throw Exception('Server Error');
      default:
        throw Exception('Something went wrong');
    }
  }
}