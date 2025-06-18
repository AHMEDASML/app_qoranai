import 'package:Al_Arqam/core/resources/global_functions.dart';

class HeaderUtil {
  static Future<Map<String, String>> getHeaders() async {
    var token = await GlobalFunctions.getToken();
      print('tokenhhhhhhhh ${token}');
    return {
       'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language':GlobalFunctions.getLangCode()!,
      'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, String>> getHeaderswithoutoken() async {
  
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language':GlobalFunctions.getLangCode()!,
      
    };
  }
   static  Future<bool> isToken() async{
     var token = await GlobalFunctions.getToken();
     return token==null?false:true;

  }
}
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}


class ErrorHandler {
  static ApiException handleError(int statusCode) {
  
    switch (statusCode) {
      case 400:
        return ApiException('Bad request. Please check your input.');
      case 401:
        return ApiException('Unauthorized access. Please log in again.');
      case 403:
        return ApiException('Forbidden. You do not have permission to access this resource.');
      case 404:
        return ApiException('Resource not found. Please try again later.');
      case 500:
        return ApiException('Server error. Please try again later.');
      default:
        return ApiException('Unexpected error: $statusCode. Please try again later.');
    }
  }
}