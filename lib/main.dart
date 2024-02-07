import 'package:flutter/material.dart';
import 'package:shaparak/widgets/bottom_navigation.dart';

import 'di/di.dart';

void main() async {
  await getInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigation(),
    );
  }
}
