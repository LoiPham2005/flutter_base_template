import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bottom Menu Page',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}