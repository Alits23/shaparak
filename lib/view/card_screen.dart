import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:shaparak/util/extenstions/string_extensions.dart';
import '../constans/color.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                const AppBarCard(),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 5,
                    (context, index) {
                      return const CardItem();
                    },
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 60.0),
                ),
              ],
            ),
            const ButtonBuy(),
          ],
        ),
      ),
    );
  }
}

class ButtonBuy extends StatelessWidget {
  const ButtonBuy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 44.0, right: 44.0, bottom: 10.0),
      child: SizedBox(
        height: 53,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontFamily: 'sm',
              fontSize: 18.0,
            ),
            backgroundColor: CustomColors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          onPressed: () {},
          child: const Text(
            'ادامه فرایند خرید',
            style: TextStyle(
              fontFamily: 'sm',
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarCard extends StatelessWidget {
  const AppBarCard({
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
                  'سبد خرید',
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

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 44.0, right: 44.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'آیفون 13 پرو مکس',
                          style: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'گارانتی مادام العمر زیلینک',
                          style: TextStyle(
                              fontFamily: 'sm',
                              fontSize: 12.0,
                              color: CustomColors.gery),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColors.red,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 6.0),
                                child: Text(
                                  '%3',
                                  style: TextStyle(
                                    fontFamily: 'sb',
                                    fontSize: 12,
                                    color: CustomColors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text(
                              'تومان',
                              style: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Text(
                              '49،000،000',
                              style: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            const DeleteProduct(),
                            OptionCheap('آبی فیروزه ای', color: '4287f5'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.asset('assets/images/iphone.png'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DottedLine(
              lineThickness: 3.0,
              dashLength: 8.0,
              dashColor: CustomColors.gery.withOpacity(0.5),
              dashGapLength: 3.0,
              dashGapColor: Colors.transparent,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تومان',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '49،000،000',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteProduct extends StatelessWidget {
  const DeleteProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'حذف',
              style: TextStyle(
                fontFamily: 'sm',
                fontSize: 12.0,
                color: CustomColors.red,
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Image.asset('assets/images/icon_trash.png'),
          ],
        ),
      ),
    );
  }
}

class OptionCheap extends StatelessWidget {
  String title;
  String? color;
  OptionCheap(this.title, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.gery,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontFamily: 'sm', fontSize: 12.0),
            ),
            if (color != null) ...{
              Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parseToColor(),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
