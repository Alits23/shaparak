import 'package:flutter/material.dart';
import 'package:shaparak/view/category_screen.dart';
import 'package:shaparak/view/home_screen.dart';
import 'package:shaparak/view/product_list_screen.dart';
import 'package:shaparak/widgets/bottom_navigation.dart';

void main() {
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
