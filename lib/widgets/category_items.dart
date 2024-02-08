import 'package:flutter/material.dart';
import 'package:shaparak/data/model/category.dart';
import 'package:shaparak/widgets/cashed_image.dart';

import '../constans/color.dart';

class CategoryItems extends StatelessWidget {
  Category listCategory;
  CategoryItems(this.listCategory, {super.key});

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'ff${listCategory.color}';
    int hexColorCategories = int.parse(categoryColor, radix: 16);
    return Column(
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: ShapeDecoration(
            color: Color(hexColorCategories),
            shadows: [
              BoxShadow(
                color: Color(hexColorCategories),
                blurRadius: 25,
                spreadRadius: -12,
                offset: const Offset(0.0, 15.0),
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CashedImage(
                imageUrl: listCategory.icon,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          listCategory.title!,
          style: const TextStyle(
            fontFamily: 'sb',
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
