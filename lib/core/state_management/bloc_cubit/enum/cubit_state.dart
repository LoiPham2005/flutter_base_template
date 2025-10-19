
import 'package:equatable/equatable.dart';
import 'package:flutter_base_template/core/state_management/bloc_status.dart';

class CubitState<T> extends Equatable {
 final BlocStatus status;
 final T? data;
 final String msg;
 final int total;

  const CubitState({
    this.status = BlocStatus.initial,
    this.total = 0,
    this.data,
    this.msg = "Lỗi. Kết nối tới máy chủ thất bại",
  });

  CubitState<T> copyWith({
    BlocStatus? status,
    T? data,
    String? msg,
    int? total,
  }) {
    return CubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      msg: msg ?? this.msg,
      total: total ?? this.total,
    );
  }

  @override
// TODO: implement props
  List<Object?> get props => [status, data, msg, total];
}
