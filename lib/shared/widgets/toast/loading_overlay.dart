import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingOverlay extends StatelessWidget {
  // final bool isLoading;
  final Widget? child;

  const LoadingOverlay({
    super.key,
    // required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? SizedBox.shrink(),
        // if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.grey.withOpacity(0.5),
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
