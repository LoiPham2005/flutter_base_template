import 'package:flutter_base_template/core/state_management/bloc/base_event.dart';
import 'package:flutter_base_template/core/state_management/bloc/base_state.dart';
import 'package:flutter_base_template/core/state_management/bloc/bloc_helper.dart';
import 'package:flutter_base_template/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_base_template/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/storage/storage_service.dart';
import '../../domain/usecases/logout_usecase.dart';

class LoginEvent extends BaseEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LogoutEvent extends BaseEvent {}

@injectable
class AuthBloc extends Bloc<BaseEvent, BaseState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final StorageService _storageService = getIt<StorageService>();

  AuthBloc({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
  }) : _loginUseCase = loginUseCase,
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
      onSuccess: (data) async {
        // Lưu token và trạng thái login vào storage
        await _storageService.saveToken(data.accessToken);
        await _storageService.saveRefreshToken(data.refreshToken);
        await _storageService.setLoggedIn(true);
      },
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<BaseState> emit) async {
    await execute<bool, BaseState>(
      emit: emit,
      useCaseCall: () => _logoutUseCase(),
      stateBuilder: ({status, data, errorMessage}) =>
          state.copyWith(status: status, data: null, error: errorMessage),
      onSuccess: (_) async {
        await _storageService.clearAuthData();
      },
    );
  }
}
