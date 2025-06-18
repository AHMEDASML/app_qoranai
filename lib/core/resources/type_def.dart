import 'package:dartz/dartz.dart';

import '../handling_error/failures.dart';

typedef FromJson<T> = T Function(String body);

typedef QueryParams = Map<String, String>;

typedef BodyMap = Map<String, dynamic>;

typedef DataResponse<T> = Future<Either<Failure, T>>;

mixin Params {
  BodyMap getBody() => {};

  QueryParams getParams() => {};
}

class NoParams with Params {}

