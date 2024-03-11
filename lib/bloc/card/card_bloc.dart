import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/card/card_event.dart';
import 'package:shaparak/bloc/card/card_state.dart';
import 'package:shaparak/util/extenstions/string_extensions.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

import '../../data/repository/basket_repository.dart';
import '../../di/di.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final IBasketRepository _basketRepository = locator.get();
  PaymentRequest _paymentRequest = PaymentRequest();

  CardBloc() : super(CardInitState()) {
    on<CardRequestDataEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItem();
      var finalPrice = await _basketRepository.getBasketFinalPrice();
      emit(CardResponsState(
        basketItemList,
        finalPrice,
      ));
    });

    on<CardPaymentInitEvent>(
      (event, emit) async {
        //setisSandBox baraye shabeh sazie
        _paymentRequest.setIsSandBox(true);
        _paymentRequest.setAmount(1000);
        _paymentRequest.setDescription('this is for app shaparak :)');
        _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c305eb8fc');
        _paymentRequest.setCallbackURL('expertflutter://shop');

        //control deeplinl
        linkStream.listen((deeplink) {
          if (deeplink!.toLowerCase().contains('authority')) {
            String? authority = deeplink.extractValueFromQuery('Authority');
            String? status = deeplink.extractValueFromQuery('Status');
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
      },
    );
    on<CardPaymentRequestEvent>(
      (event, emit) async {
        ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
          if (status == 100) {
            launchUrl(Uri.parse(paymentGatewayUri!),
                mode: LaunchMode.externalApplication);
          }
        });
      },
    );
  }
}
