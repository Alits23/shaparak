import 'package:flutter/material.dart';
import 'package:shaparak/constans/color.dart';
import 'package:shaparak/widgets/banner_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BannerSlider(),
      ),
    );
  }
}
