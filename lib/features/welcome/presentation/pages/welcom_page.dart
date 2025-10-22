import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/extensions/context_extensions.dart';
import 'package:flutter_base_template/features/auth/presentation/pages/login_page.dart';

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the App!',
              // style: Theme.of(context).textTheme.bodyLarge,
              style: TextStyle(color: context.colorScheme.secondary),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(const LoginPage());
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
