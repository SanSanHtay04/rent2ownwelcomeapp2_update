import 'package:flutter/material.dart';

import '../values/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

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
