// lib/features/auth/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/extensions/context_extensions.dart';
import 'package:flutter_base_template/core/state_management/bloc/base_state.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/features/home/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:nb_utils/nb_utils.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocConsumer<AuthBloc, BaseState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.showSuccessSnackBar('Login successful!');

            final authResponse = state.data;
            if (authResponse != null) {
              getIt<StorageService>()
                ..saveToken(authResponse.accessToken)
                ..saveRefreshToken(authResponse.refreshToken)
                ..setLoggedIn(true);

              context.pushReplacement(const HomePage());
            }
          } else if (state.isFailure) {
            context.showErrorSnackBar(state.error ?? 'Login failed');
          }
        },
        builder: (context, state) {
          final isLoading = state.isLoading;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                enabled: !isLoading,
              ),
              16.height,
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                enabled: !isLoading,
              ),
              24.height,
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<AuthBloc>().add(
                          LoginEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login'),
              ).withSize(width: double.infinity, height: 48),
            ],
          ).paddingAll(16);
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
