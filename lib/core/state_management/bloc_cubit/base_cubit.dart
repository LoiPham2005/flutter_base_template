import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_state.dart';

abstract class BaseCubit extends Cubit<BaseState> {
  BaseCubit(initialState) : super(InitialState()) {
    onInit(); // tự động gọi khi Cubit được tạo
  }

  /// Hàm khởi tạo logic chung hoặc override ở Cubit con
  void onInit() {
    print('[CUBIT INIT] ${runtimeType}');
  }

  /// Ghi log khi state thay đổi
  // @override
  // void onChange(Change<BaseState> change) {
  //   super.onChange(change);
  //   print('[CUBIT STATE CHANGE] ${change.currentState.runtimeType} → ${change.nextState.runtimeType}');
  // }

  /// Ghi log khi lỗi
  @override
  void onError(Object error, StackTrace stackTrace) {
    print('[CUBIT ERROR] $error');
    super.onError(error, stackTrace);
  }

  /// Hàm dùng chung cho hành động async (login, register, fetch...)
  Future<T?> performAction<T>({
    required Future<T> Function() action,
    String? loadingMessage,
    String? successMessage,
  }) async {
    final loadingMsg = loadingMessage ?? 'Đang xử lý, vui lòng chờ...';
    final successMsg = successMessage ?? 'Thành công!';
    emit(LoadingState(message: loadingMsg));

    try {
      final result = await action();
      emit(LoadedState<T>(result, message: successMsg));
      return result;
    } catch (e, stackTrace) {
      print('[CUBIT ERROR LOG] $e\n$stackTrace');
      emit(ErrorState(e.toString()));
      return null;
    }
  }

  /// Safe emit
  void safeEmit(BaseState state) {
    if (!isClosed) emit(state);
  }

  /// Ghi log khi đóng Cubit
  @override
  Future<void> close() {
    print('[CUBIT CLOSED] ${runtimeType}');
    onDispose();
    return super.close();
  }

  /// Override để cleanup tài nguyên
  void onDispose() {
    print('[CUBIT DISPOSED] ${runtimeType}');
  }
}
