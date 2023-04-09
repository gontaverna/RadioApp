import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Home(),
      title: 'RadioApp',
      debugShowCheckedModeBanner: false,
    );
  }
}
