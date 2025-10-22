import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/extensions/context_extensions.dart';
import 'package:flutter_base_template/core/extensions/localization_x.dart';
import 'package:nb_utils/nb_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          Center(child: Text(context.l10n.appTitle)),
          10.height,
          ElevatedButton(
            onPressed: () {
              context.push(const Page2());
            },
            child: const Text('chuyển màn '),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
