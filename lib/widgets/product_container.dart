import 'package:flutter/material.dart';

import '../constans/color.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Image.asset('assets/images/iphone.png'),
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
                  child: const Text(
                    '99%',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'آیفون 13 پرو مکس',
                style: TextStyle(
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
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '69/000/000',
                          style: TextStyle(
                              color: CustomColors.white,
                              fontSize: 12.0,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'sm'),
                        ),
                        Text(
                          '69/000/000',
                          style: TextStyle(
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
    );
  }
}
