import 'package:equatable/equatable.dart';
import 'package:flutter_base_template/core/state_management/bloc/base_event.dart';
import 'package:flutter_base_template/core/state_management/bloc/base_state.dart';
import 'package:flutter_base_template/core/state_management/bloc/bloc_helper.dart';
import 'package:flutter_base_template/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_base_template/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

class LoginEvent extends BaseEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

@injectable
class AuthBloc extends Bloc<BaseEvent, BaseState> {
  final LoginUseCase _loginUseCase;

  AuthBloc({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(BaseState.initial()) {
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<BaseState> emit,
  ) async {
    await handleBlocRequest<AuthResponse, BaseState>(
      emit,
      () => _loginUseCase(
        email: event.email,
        password: event.password,
      ),
      ({status, data, error}) => state.copyWith(
        status: status,
        data: data ?? state.data,
        error: error,
      ),
      onSuccess: (data) {
        
      },
    );
  }
}