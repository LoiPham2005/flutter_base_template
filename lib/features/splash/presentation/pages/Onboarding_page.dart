import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/routes/app_routes.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  final VoidCallback? onComplete;

  const OnboardingPage({this.onComplete, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the app!'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // onComplete?.call();
                // Navigator.of(context).pop();
                print("click Onboarding");
                context.router.replaceAll([const BottomMenuRoute()]);
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
