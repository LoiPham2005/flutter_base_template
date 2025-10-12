import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/extensions/localization_x.dart';
import 'package:flutter_base_template/core/l10n/app_localizations.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Text(context.tr.appTitle),
      ),
    );
  }
}