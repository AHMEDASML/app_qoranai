import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:http/http.dart' as http;

import '../handling_error/handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class MultiPostApi with HandlingExceptionRequest {
  final Uri uri;
  final Map<String, String> body;
  final FromJson fromJson;
  final Duration timeout;

  const MultiPostApi({
    required this.uri,
    required this.body,
    required this.fromJson,
    this.timeout = const Duration(seconds: 20),
  });

  Future<dynamic> callRequest() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept-Language':GlobalFunctions.getLangCode()!,
        'Accept': 'application/json',
      };
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      for (var item in body.entries) {
        request.files
            .add(await http.MultipartFile.fromPath(item.key, item.value));
      }

      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(timeout);
      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body);
      log(response.statusCode.toString());
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
      //rethrow;
    } catch (e) {
      log(
        e.toString(),
        name: 'RequestManager post function',
      );
      rethrow;
    }
  }
}
