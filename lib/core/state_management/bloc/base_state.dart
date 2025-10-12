// import 'package:equatable/equatable.dart';

// /// Base class cho tất cả state.
// /// Giúp đồng nhất giữa các BLoC (CategoryBloc, ProductBloc, ...)
// abstract class BaseState extends Equatable {
//   const BaseState();

//   @override
//   List<Object?> get props => [];
// }

// /// State khởi tạo
// class InitialState extends BaseState {}

// /// State đang tải dữ liệu
// class LoadingState extends BaseState {}

// /// State tải thành công
// class LoadedState<T> extends BaseState {
//   final T data;

//   const LoadedState(this.data);

//   @override
//   List<Object?> get props => [data];
// }

// /// State lỗi
// class ErrorState extends BaseState {
//   final String message;

//   const ErrorState(this.message);

//   @override
//   List<Object?> get props => [message];
// }


// lib/core/bloc/base_state.dart

import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();
  
  @override
  List<Object?> get props => [];
}