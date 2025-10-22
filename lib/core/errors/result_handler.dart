import 'package:flutter_base_template/core/errors/exceptions.dart';
import 'package:flutter_base_template/core/errors/result.dart';

abstract class ResultHandler {
  T handleResult<T>(Result<T> result) {
    return result.fold(
      onSuccess: (data) => data,
      onFailure: (failure) => throw ServerException(message: failure.message),
    );
  }
}
