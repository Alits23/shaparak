import 'package:flutter/material.dart';

import '../constans/color.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: ShapeDecoration(
            color: CustomColors.blueIndicator,
            shadows: const [
              BoxShadow(
                color: CustomColors.green,
                blurRadius: 25,
                spreadRadius: -12,
                offset: Offset(0.0, 15.0),
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: const Icon(
            Icons.apple,
            color: CustomColors.white,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          'اپل واچ',
          style: TextStyle(
            fontFamily: 'sb',
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
