import 'package:flutter/material.dart';
import 'package:shaparak/data/model/banner.dart';
import 'package:shaparak/widgets/cashed_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constans/color.dart';

class BannerSlider extends StatelessWidget {
  List<BannerCampaign> listBanner;
  BannerSlider(this.listBanner, {super.key});

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
              return CashedImage(imageUrl: listBanner[index].thumbnail);
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
