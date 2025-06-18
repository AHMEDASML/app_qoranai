import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../handling_error/handling_exception_request.dart';
import '../resources/global_functions.dart';

typedef FromJson<T> = T Function(String body);

class DeleteApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final FromJson fromJson;
  DeleteApi({
    required this.uri,
    required this.fromJson,
  });
  Future<T> callRequest() async {
    String? token = await GlobalFunctions.getToken();
    bool isAuth = GlobalFunctions.isAuth();
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language':GlobalFunctions.getLangCode()!,
        if (isAuth) 'Authorization': 'Bearer $token',
      };
      var response = await http.delete(
        uri,
        headers: headers,
      );

      log(response.body);
      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception exception =
            getException(message: json.decode(response.body)['message']);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception',
        name: 'RequestManager get function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri',
        name: 'RequestManager get function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception',
        name: 'RequestManager get function',
      );
      Exception exception = getException(message: "No Internet");
      throw exception;
      // rethrow;
    } catch (e) {
      log(
        e.toString(),
        name: 'RequestManager get function',
      );
      rethrow;
    }
  }
}
