import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

/// Layout with a busy state with an optional appbar.
class WorkLayout extends StatelessWidget {
  final bool isBusy;
  final Widget child;
  final AppBar? appBar;

  const WorkLayout({
    super.key,
    required this.isBusy,
    required this.child,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (isBusy) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }
    });
    return Scaffold(
      appBar: appBar,
      backgroundColor: context.getColorScheme().surface,
      body: SafeArea(
        child: child,
      ),
    );
  }
}
