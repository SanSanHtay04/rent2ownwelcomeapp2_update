import 'package:flutter/material.dart';

class CopyrightNotice extends StatelessWidget {
  const CopyrightNotice({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
      height: 30,
      child: Align(
        alignment: Alignment.center,
        child: Text("Copyright @ 2024 Rent 2 Own Myanmar",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ));
}
