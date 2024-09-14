import 'package:flutter/material.dart';

class FullscreenProgressIndicator extends StatelessWidget {
  const FullscreenProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
