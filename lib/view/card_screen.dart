import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/card/card_bloc.dart';
import 'package:shaparak/bloc/card/card_state.dart';
import 'package:shaparak/util/extenstions/string_extensions.dart';
import 'package:shaparak/widgets/cashed_image.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';
import '../constans/color.dart';
import '../data/model/basket_item.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  PaymentRequest _paymentRequest = PaymentRequest();
  @override
  void initState() {
    super.initState();
    //setisSandBox baraye shabeh sazie
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(1000);
    _paymentRequest.setDescription('this is for app shaparak :)');
    _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c305eb8fc');
    _paymentRequest.setCallbackURL('expertflutter://shop');
    //control deeplinl
    linkStream.listen((deeplink) {
      if (deeplink!.toLowerCase().contains('authority')) {
        String? authority = extractValueFromQuery(deeplink, 'Authority');
        String? status = extractValueFromQuery(deeplink, 'Status');
        ZarinPal().verificationPayment(status!, authority!, _paymentRequest,
            (isPaymentSuccess, refID, paymentRequest) {
          if (isPaymentSuccess) {
            print(refID);
          } else {
            print(status);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(child: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  const AppBarCard(),
                  if (state is CardResponsState) ...{
                    state.basketItemList.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (basketItemList) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: basketItemList.length,
                          (context, index) {
                            return CardItem(basketItemList[index]);
                          },
                        ),
                      );
                    })
                  },
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 60.0),
                  ),
                ],
              ),
              if (state is CardResponsState) ...{
                ButtonBuy(state.basketFinalPrice, _paymentRequest),
              },
            ],
          );
        },
      )),
    );
  }
}

class ButtonBuy extends StatelessWidget {
  PaymentRequest paymentRequest;
  int finalPrice;
  ButtonBuy(
    this.finalPrice,
    this.paymentRequest, {
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
          onPressed: () {
            ZarinPal().startPayment(paymentRequest,
                (status, paymentGatewayUri) {
              if (status == 100) {
                launchUrl(Uri.parse(paymentGatewayUri!),
                    mode: LaunchMode.externalApplication);
              }
            });
          },
          child: Text(
            (finalPrice == 0) ? '!!! سبد خرید شما خالیه ' : '$finalPrice',
            style: const TextStyle(
              fontFamily: 'sm',
              fontSize: 18.0,
              color: CustomColors.white,
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
  BasketItem basketItem;
  CardItem(
    this.basketItem, {
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
                        Text(
                          basketItem.name,
                          style: const TextStyle(
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 6.0),
                                child: Text(
                                  '${basketItem.persent!.toInt()} %',
                                  style: const TextStyle(
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
                            Text(
                              '${basketItem.price}',
                              style: const TextStyle(
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
                  child: SizedBox(
                    width: 75,
                    height: 104,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CashedImage(
                        imageUrl: basketItem.thumbnail,
                      ),
                    ),
                  ),
                ),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تومان',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  '${basketItem.realPrice}',
                  style: const TextStyle(
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

String? extractValueFromQuery(String url, String key) {
  // Remove everything before the question mark
  int queryStartIndex = url.indexOf('?');
  if (queryStartIndex == -1) return null;

  String query = url.substring(queryStartIndex + 1);

  // Split the query into key-value pairs
  List<String> pairs = query.split('&');

  // Find the key-value pair that matches the given key
  for (String pair in pairs) {
    List<String> keyValue = pair.split('=');
    if (keyValue.length == 2) {
      String currentKey = keyValue[0];
      String value = keyValue[1];

      if (currentKey == key) {
        // Decode the URL-encoded value
        return Uri.decodeComponent(value);
      }
    }
  }

  return null;
}
