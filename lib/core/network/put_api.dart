import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../resources/global_functions.dart';
import '../handling_error/handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class PutApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final Map body;
  final FromJson fromJson;
  final bool isLogin;
  final Duration timeout;

  const PutApi({
    required this.uri,
    required this.body,
    required this.fromJson,
    this.isLogin = false,
    this.timeout = const Duration(seconds: 40),
  });

  Future<T> callRequest() async {
    String? token = await GlobalFunctions.getToken();
    bool isAuth = GlobalFunctions.isAuth();

    // log('the token in the request header is $token',
    //     name: 'request manager ==> post function ');
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language':GlobalFunctions.getLangCode()!,
        if (isAuth) 'Authorization': 'Bearer $token',
      };
      log("$token");
      var response = await http
          .put(
            uri,
            body: jsonEncode(body),
            headers: headers,
          )
          .timeout(timeout);

      log(response.body);
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
        name: 'RequestManager post function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri',
        name: 'RequestManager post function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception',
        name: 'RequestManager post function',
      );
      Exception exception = getException(message: "No Internet");
      throw exception;
      // rethrow;
    } catch (e) {
      log(
        e.toString(),
        name: 'RequestManager post function',
      );
      rethrow;
    }
  }
}
