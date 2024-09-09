import 'package:flutter/material.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/view/product_list_screen.dart';
import 'package:shaparak/widgets/product_container.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key, required this.productList});
  final List<Product> productList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const AppBarProductList('پرفروش ترین ها ترین ها'),
            SliverPadding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: productList.length,
                  (context, index) => ProductContainer(productList[index]),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 2 / 2.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
