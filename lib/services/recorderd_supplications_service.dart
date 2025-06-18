import 'dart:convert';
import 'package:Al_Arqam/core/network/network_util.dart';
import 'package:Al_Arqam/models/recorded_supplications/recorded_supplications_model.dart';
import 'package:http/http.dart' as http;

class RecorderdSupplicationsService {
  final String baseUrl = 'https://api.alarqambh.com/api/supplication';

  Future<List<Supplication>> fetchSupplications({
    required int startIndex,
    required int limit,
    required String classification,
    bool? fav, // Make fav an optional parameter
    String? searchTerm,
  }) async {
    try {
      Map<String, String> headers = await HeaderUtil.getHeaders();

      
      String url = '$baseUrl/get-supplications?startIndex=$startIndex&limit=$limit&classification=$classification';
      
    

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
         print('.....................${response.statusCode}');
        final List<dynamic> jsonList = json.decode(response.body)['supplications'];
        return jsonList.map((json) => Supplication.fromJson(json)).toList();
      } else {
         print('.....................${response.statusCode}');
        throw ErrorHandler.handleError(response.statusCode);
      }
    } on Exception catch (e) {
      print('Error occurred: $e');
      throw ApiException('An error occurred while fetching supplications. Please try again later.');
    }
  }
}