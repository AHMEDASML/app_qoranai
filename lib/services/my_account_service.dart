import 'dart:convert';

import 'package:Al_Arqam/models/general_model.dart';
import 'package:http/http.dart' as http;
import 'package:Al_Arqam/core/network/network_util.dart';

class MyAccountService {
  final String baseUrl = 'https://api.alarqambh.com/api';

 
  Future<GeneralModel> updateMyAccount({
   
    Object? body,
  }) async {
    try {
      Map<String, String> headers = await HeaderUtil.getHeaders();
      String url = '$baseUrl/profile/update-profile';
      
    
      final message = jsonEncode(body);

      final response = await http.put(Uri.parse(url), headers:headers, body:message);
     
      if (response.statusCode == 200||response.statusCode == 201) {
        return GeneralModel.fromJson(json.decode(response.body));
      } else {
        throw ErrorHandler.handleError(response.statusCode);
      }
    } on Exception catch (e) {
      throw ApiException('An error occurred while fetching inquiries. Please try again later');
    }
  }
}
