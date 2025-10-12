// lib/core/errors/result.dart
// Result pattern for better error handling

import 'package:flutter_base_template/core/errors/failures.dart';

abstract class Result<T> {
  const Result();
  
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Error<T>;
  
  T? get data => isSuccess ? (this as Success<T>).value : null;
  Failure? get error => isFailure ? (this as Error<T>).failure : null;
  
  // Fold pattern
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    if (isSuccess) {
      return onSuccess((this as Success<T>).value);
    } else {
      return onFailure((this as Error<T>).failure);
    }
  }
  
  // Map
  Result<R> map<R>(R Function(T data) transform) {
    if (isSuccess) {
      return Success(transform((this as Success<T>).value));
    } else {
      return Error((this as Error<T>).failure);
    }
  }
  
  // FlatMap
  Result<R> flatMap<R>(Result<R> Function(T data) transform) {
    if (isSuccess) {
      return transform((this as Success<T>).value);
    } else {
      return Error((this as Error<T>).failure);
    }
  }
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}