import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

class LoadDataEvent<T> extends BaseEvent {
  final Map<String, dynamic>? params;

  const LoadDataEvent({this.params});

  @override
  List<Object?> get props => [params];
}

class LoadDetailEvent<T> extends BaseEvent {
  final String id;

  const LoadDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}
