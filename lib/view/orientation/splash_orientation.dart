import 'package:flutter/material.dart';

class SplashOrientation extends StatelessWidget {
  const SplashOrientation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        return SplashOrientation();
      } else {
        return SplashOrientation();
      }
    }));
  }
}
