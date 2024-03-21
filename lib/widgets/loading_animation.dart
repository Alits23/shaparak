import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shaparak/constans/color.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 60.0,
      height: 60.0,
      child: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [CustomColors.blue],
          strokeWidth: 1,
        ),
      ),
    );
  }
}
