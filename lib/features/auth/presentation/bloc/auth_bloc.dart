import 'package:flutter_base_template/core/state_management/bloc/base_event.dart';
import 'package:flutter_base_template/core/state_management/bloc/base_state.dart';
import 'package:flutter_base_template/core/state_management/bloc/bloc_helper.dart';
import 'package:flutter_base_template/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_base_template/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/storage/storage_service.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../pages/login_page.dart';

class LoginEvent extends BaseEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

// Thêm LogoutEvent
class LogoutEvent extends BaseEvent {}

@injectable
class AuthBloc extends Bloc<BaseEvent, BaseState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc({required LoginUseCase loginUseCase,
  required LogoutUseCase logoutUseCase,})
    : _loginUseCase = loginUseCase,
    _logoutUseCase = logoutUseCase,
      super(BaseState.initial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<BaseState> emit) async {
    await execute<AuthResponse, BaseState>(
      emit: emit,
      useCaseCall: () =>
          _loginUseCase(email: event.email, password: event.password),
      stateBuilder: ({status, data, errorMessage}) => state.copyWith(
        status: status,
        data: data ?? state.data,
        error: errorMessage,
      ),
      onSuccess: (data) {
        // Xử lý khi đăng nhập thành công
      },
      onFailure: (failure) {
        // Xử lý khi đăng nhập thất bại
      },
    );
  }

   // Thêm logout handler
  Future<void> _onLogout(LogoutEvent event, Emitter<BaseState> emit) async {
    await execute<bool, BaseState>(
      emit: emit,
      useCaseCall: () => _logoutUseCase(),
      stateBuilder: ({status, data, errorMessage}) => state.copyWith(
        status: status,
        data: null,  // Clear auth data
        error: errorMessage,
      ),
      onSuccess: (_) {
        // Clear local storage
        getIt<StorageService>().clearAuthData();
        // Navigate to login
        getIt<NavigationService>().pushAndRemoveUntil(
          const LoginPage(),
          (route) => false,
        );
      },
    );
  }
}
