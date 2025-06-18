import 'dart:convert';
import 'package:Al_Arqam/models/camping_mufti/ask_camping_mufti_model.dart';
import 'package:Al_Arqam/models/general_model.dart';
import 'package:http/http.dart' as http;
import 'package:Al_Arqam/core/network/network_util.dart';

class InquiryService {
  final String baseUrl = 'https://api.alarqambh.com/api';

  Future<InquiriesResponse> fetchInquiries({
    required String type,
    required int startIndex,
    required int limit,
    String? searchTerm,
  }) async {
    try {
      Map<String, String> headers = await HeaderUtil.getHeaders();
      String url = '$baseUrl/inquiry/get-inquiries?type=$type&startIndex=$startIndex&limit=$limit';
      
      // Add searchTerm if provided
      if (searchTerm != null && searchTerm.isNotEmpty) {
        url += '&searchTerm=$searchTerm';
      }

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return InquiriesResponse.fromJson(json.decode(response.body));
      } else {
        throw ErrorHandler.handleError(response.statusCode);
      }
    } on Exception catch (e) {
      throw ApiException('An error occurred while fetching inquiries. Please try again later');
    }
  }
  Future<GeneralModel> addInquiries({
   
    Object? body,
  }) async {
    try {
      Map<String, String> headers = await HeaderUtil.getHeaders();
      String url = '$baseUrl/inquiry/add-inquiry';
      
    
      final message = jsonEncode(body);

      final response = await http.post(Uri.parse(url), headers:headers, body:message);
      //  print('llllllllllllllllllllll${response.statusCode}');
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
