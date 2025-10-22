// lib/features/auth/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/extensions/context_extensions.dart';
import 'package:flutter_base_template/core/state_management/bloc/base_state.dart';
import 'package:flutter_base_template/core/state_management/bloc/bloc_status.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/features/home/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/di/injection.dart';
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
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<AuthBloc, BaseState>(
          listener: (context, state) {
            if (state.status == BlocStatus.success) { // ✅ sửa ở đây
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login successful!'),
                  backgroundColor: Colors.green,
                ),
              );

              final authResponse = state.data;
              if (authResponse != null) {
                getIt<StorageService>()
                  ..saveToken(authResponse.accessToken)
                  ..saveRefreshToken(authResponse.refreshToken)
                  ..setLoggedIn(true);

                context.pushReplacement(const HomePage());
              }
            } else if (state.status == BlocStatus.failure) { // ✅ sửa ở đây
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error ?? 'Login failed'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state.status == BlocStatus.loading; // ✅ sửa ở đây

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
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
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
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
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
