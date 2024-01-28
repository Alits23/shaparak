import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bannerController =
      PageController(viewportFraction: 0.8, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: 177.0,
              child: PageView.builder(
                controller: bannerController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Center(
                      child: Text('${index + 1}'),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 10.0,
              child: SmoothPageIndicator(
                controller: bannerController,
                count: 3,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.blueAccent,
                  dotColor: Colors.white,
                  expansionFactor: 4.0,
                  dotHeight: 9.0,
                  dotWidth: 9.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
