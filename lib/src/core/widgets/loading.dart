import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';


class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: const Center(
      child: CircularProgressIndicator(
        color: bg1Color,
      ),
    ));
  }
}
