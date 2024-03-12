import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/product_list/product_list_bloc.dart';
import 'package:shaparak/data/model/category.dart';
import 'package:shaparak/view/product_list_screen.dart';
import 'package:shaparak/widgets/cashed_image.dart';

class CategoryItems extends StatelessWidget {
  final Category category;
  const CategoryItems(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'ff${category.color}';
    int hexColorCategories = int.parse(categoryColor, radix: 16);
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ProductListBloc(),
                  child: ProductListScreen(category),
                ),
              ),
            );
          },
          child: Container(
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
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: CashedImage(
                    imageUrl: category.icon,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          category.title,
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
