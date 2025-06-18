

import 'exceptions.dart';

mixin HandlingExceptionRequest {
  Exception getException({required String message}) {
    // final String message = json.decode(response.body)['message'];
    return ServerException(message);
  }
}
