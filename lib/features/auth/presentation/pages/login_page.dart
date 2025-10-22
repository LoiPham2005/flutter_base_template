import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/state_management/bloc/bloc_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/extensions/context_extensions.dart';
import 'package:flutter_base_template/core/state_management/bloc/base_state.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/core/utils/validators.dart';
import 'package:flutter_base_template/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_base_template/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: BlocConsumer<AuthBloc, BaseState>(
        listener: (context, state) {
          if (state.status == BlocStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Đăng nhập thất bại')),
            );
          }
          if (state.status == BlocStatus.success) {
            // Save auth data
            final authResponse = state.data;
            if (authResponse != null) {
              getIt<StorageService>()
                ..saveToken(authResponse.accessToken)
                ..saveRefreshToken(authResponse.refreshToken)
                ..setLoggedIn(true);

              // Navigate to home
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.status == BlocStatus.loading
                          ? null
                          : () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(
                                  LoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              }
                            },
                      child: state.status == BlocStatus.loading
                          ? const CircularProgressIndicator()
                          : const Text('Đăng nhập'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
