// lib/core/cubit/base_state.dart
import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

class InitialState extends BaseState {}

class LoadingState extends BaseState {
  final String message;
  const LoadingState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class LoadedState<T> extends BaseState {
  final T data;
  final String? message;
  const LoadedState(this.data, {this.message});

  @override
  List<Object?> get props => [data, message];
}

class ErrorState extends BaseState {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
