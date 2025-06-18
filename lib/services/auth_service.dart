import 'dart:convert';
import 'package:Al_Arqam/models/general_model.dart';
import 'package:http/http.dart' as http;
import 'package:Al_Arqam/core/network/network_util.dart';

class AuthService {
  final String baseUrl = 'https://api.alarqambh.com/api';

  Future<GeneralModel> logout(
  
  ) async {
    try {
      Map<String, String> headers = await HeaderUtil.getHeaders();
      String url = '$baseUrl/auth/logout';
      

      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return GeneralModel.fromJson(json.decode(response.body));
      } else {
        throw ErrorHandler.handleError(response.statusCode);
      }
    } on Exception catch (e) {
      throw ApiException('An error occurred while fetching inquiries. Please try again later');
    }
  }
  Future<GeneralModel> deleteAccount({
   
    Object? body,
  }) async {
    try {
      Map<String, String> headers = await HeaderUtil.getHeaders();
      String url = '$baseUrl/auth/delete-account';
      
    
      final message = jsonEncode(body);

      final response = await http.delete(Uri.parse(url), headers:headers, body:message);
      
      if (response.statusCode == 200||response.statusCode == 201) {
        return GeneralModel.fromJson(json.decode(response.body));
      } else {
        print("llllllllllllllllllllllll${response}");
        throw ErrorHandler.handleError(response.statusCode);
      }
    } on Exception catch (e) {
        print("llllllllllllllllllllllll${e}");
      throw ApiException('An error occurred while fetching inquiries. Please try again later');
    }
  }
}
