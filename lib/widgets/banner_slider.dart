import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constans/color.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController =
        PageController(viewportFraction: 0.8, keepPage: true);
    return Stack(
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
                  color: CustomColors.green,
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
              activeDotColor: CustomColors.blueIndicator,
              dotColor: CustomColors.white,
              expansionFactor: 4.0,
              dotHeight: 9.0,
              dotWidth: 9.0,
            ),
          ),
        ),
      ],
    );
  }
}
