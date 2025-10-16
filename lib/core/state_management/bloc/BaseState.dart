import 'package:equatable/equatable.dart';
import 'package:flutter_base_template/core/enum/bloc_status.dart';


class BaseState<T> extends Equatable {
  final BlocStatus status;
  final T? data;
  final String? error;

  const BaseState({required this.status, this.data, this.error});

  factory BaseState.initial({T? initialData}) {
    return BaseState(status: BlocStatus.initial, data: initialData);
  }

  BaseState<T> copyWith({
    BlocStatus? status,
    T? data,
    String? error,
  }) {
    return BaseState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, data ?? '', error ?? ''];
}
