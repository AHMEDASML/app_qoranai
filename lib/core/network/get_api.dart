import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../handling_error/handling_exception_request.dart';
import '../resources/global_functions.dart';

typedef FromJson<T> = T Function(String body);

class GetApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final FromJson fromJson;
  final Map? body;
  final bool getFCMToken;

  GetApi({
    required this.uri,
    required this.fromJson,
    this.body = const {},
    this.getFCMToken = false,
  });
  Future<T> callRequest() async {
    String? token = await GlobalFunctions.getToken();
    bool isAuth = GlobalFunctions.isAuth();
    String? deviceId = "";

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'perPage': "10",
        'Accept-Language': GlobalFunctions.getLangCode() ?? "ar",
        if (isAuth) 'Authorization': 'Bearer $token',
        if (getFCMToken) "device_id": deviceId,
      };
      log(headers.toString());
      var response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
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
      //rethrow;
    } catch (e) {
      log(
        e.toString(),
        name: 'RequestManager get function',
      );
      rethrow;
    }
  }
}
