import 'package:flutter_base_template/core/state_management/bloc/bloc_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../errors/result.dart';

/// Hàm helper dùng chung cho tất cả Bloc khi gọi UseCase
Future<void> handleBlocRequest<T, E>(
  Emitter<E> emit,
  Future<Result<T>> Function() useCaseCall,
  E Function({BlocStatus? status, T? data, String? error}) stateBuilder, {
  void Function(T data)? onSuccess,
  void Function(String error)? onError,
}) async {
  emit(stateBuilder(status: BlocStatus.loading));

  try {
    final result = await useCaseCall();

    result.fold(
      onSuccess: (data) {
        emit(stateBuilder(status: BlocStatus.success, data: data));
        onSuccess?.call(data);
      },
      onFailure: (failure) {
        final errorMsg = failure.message ?? 'Đã xảy ra lỗi';
        emit(stateBuilder(status: BlocStatus.failure, error: errorMsg));
        onError?.call(errorMsg);
      },
    );
  } catch (e) {
    const errorMsg = 'Đã xảy ra lỗi không xác định';
    emit(stateBuilder(status: BlocStatus.failure, error: errorMsg));
    onError?.call(errorMsg);
  }
}
