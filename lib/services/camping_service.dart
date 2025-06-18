import 'dart:convert';
import 'package:Al_Arqam/core/network/network_util.dart';
import 'package:Al_Arqam/models/capmping/camping_model.dart';

import 'package:http/http.dart' as http;


class CampingService {
  final String baseUrl = 'https://api.alarqambh.com/api';

  Future<CampaignApi> fetchCampaign() async {
    try {
      Map<String, String> headers = await HeaderUtil.getHeaderswithoutoken();

      final response = await http.get(Uri.parse('$baseUrl/campaign/get-campaign'), headers: headers);
        
      if (response.statusCode == 200) {
        // print(';;;;;;;;;;;;;;;;;;;;;;;${response.body}');
        return CampaignApi.fromJson(json.decode(response.body));
      } else {
        throw ErrorHandler.handleError(response.statusCode);
      }
    } on Exception catch (e) {
      
      throw ApiException('An error occurred while fetching crowding data. Please try again later.');
    }
  }
}