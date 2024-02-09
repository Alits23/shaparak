import 'package:flutter/material.dart';
import 'package:shaparak/widgets/product_container.dart';

import '../constans/color.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppBarProductList(),
            ProductGrid(),
          ],
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 44.0, right: 44.0, bottom: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) => Container(
            width: 100,
            height: 100,
            color: Colors.amber,
          ), //ProductContainer(),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 2 / 2.8,
        ),
      ),
    );
  }
}

class AppBarProductList extends StatelessWidget {
  const AppBarProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            right: 44.0, left: 44.0, bottom: 32.0, top: 5.0),
        child: Container(
          height: 56.0,
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 16.0,
              ),
              Image.asset('assets/images/icon_apple_blue.png'),
              const Expanded(
                child: Text(
                  'پرفروش ترین ها',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'sb',
                    color: CustomColors.blue,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 38.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
