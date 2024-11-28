import 'package:flutter/material.dart';

AppBar SimpleToolbar({required title}) {
  return AppBar(
    leading: BackButton(),
    title: Text(title),
  );
}
