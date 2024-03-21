import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/card/card_bloc.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/extenstions/int_extensions.dart';
import 'package:shaparak/widgets/cashed_image.dart';

import '../constans/color.dart';
import '../view/product_detail_screen.dart';

class ProductContainer extends StatelessWidget {
  final Product product;
  const ProductContainer(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<CardBloc>.value(
              value: locator.get<CardBloc>(),
              child: ProductDetailScreen(product),
            ),
          ),
        );
      },
      child: Container(
        width: 160.0,
        height: 216.0,
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 120.0,
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CashedImage(
                      imageUrl: product.thumbnail,
                    ),
                  ),
                ),
                Positioned(
                  top: 5.0,
                  right: 10.0,
                  child: Image.asset('assets/images/active_fav_product.png'),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 5.0,
                  child: Container(
                    height: 20,
                    width: 42,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.red,
                    ),
                    child: Text(
                      '${product.persent!.toInt()} %',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: CustomColors.white,
                        fontSize: 15.0,
                        fontFamily: 'sm',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'sb',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: 53.0,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.blue,
                    blurRadius: 25.0,
                    spreadRadius: -12.0,
                    offset: Offset(0.0, 15.0),
                  ),
                ],
                color: CustomColors.blueIndicator,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                        color: CustomColors.white,
                        fontSize: 12.0,
                        fontFamily: 'sm',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.price.convertToPrice(),
                            style: const TextStyle(
                                color: CustomColors.white,
                                fontSize: 12.0,
                                decoration: TextDecoration.lineThrough,
                                fontFamily: 'sm'),
                          ),
                          Text(
                            product.realPrice!.convertToPrice(),
                            style: const TextStyle(
                                color: CustomColors.white,
                                fontSize: 16.0,
                                fontFamily: 'sm'),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: Image.asset(
                          'assets/images/icon_right_arrow_cricle.png'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
