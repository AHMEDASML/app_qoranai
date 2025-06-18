import 'dart:convert';
import 'package:Al_Arqam/core/network/network_util.dart';
import 'package:Al_Arqam/models/crowading/crowading_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String baseUrl = 'https://api.alarqambh.com/api/crowding';

  Future<CrowdingResponse> fetchCrowding() async {
    try {
      Map<String, String> headers = await HeaderUtil.getHeaders();

      final response = await http.get(Uri.parse('$baseUrl/get-crowding'), headers: headers);

      if (response.statusCode == 200) {
        return CrowdingResponse.fromJson(json.decode(response.body));
      } else {
        throw ErrorHandler.handleError(response.statusCode);
      }
    } on Exception catch (e) {
      print('Error occurred: $e');
      throw ApiException('An error occurred while fetching crowding data. Please try again later.');
    }
  }
}