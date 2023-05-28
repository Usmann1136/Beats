import 'package:beats/view/orientation/splash_orientation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beats',
      theme: ThemeData(
          fontFamily: 'Poppins Courgrette',
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)),
      home: SplashOrientation(),
    );
  }
}
