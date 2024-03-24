import 'package:shaparak/util/extenstions/string_extensions.dart';
import 'package:shaparak/util/url_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest(int finalPrice);
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
}

class ZarinPalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  String? _authority;
  String? _status;
  UrlHandler urlHandler;
  ZarinPalPaymentHandler(this.urlHandler);
  @override
  Future<void> initPaymentRequest(int finalPrice) async {
    //setisSandBox baraye shabeh sazie
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(finalPrice);
    _paymentRequest.setDescription('this is for app shaparak :)');
    // 'd645fba8-1b29-11ea-be59-000c295eb8fc'
    _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c305eb8fc');
    _paymentRequest.setCallbackURL('expertflutter://shop');
    linkStream.listen((deeplink) {
      if (deeplink!.toLowerCase().contains('authority')) {
        _authority = deeplink.extractValueFromQuery('Authority');
        _status = deeplink.extractValueFromQuery('Status');
        verifyPaymentRequest();
      }
    });
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
      if (status == 100) {
        urlHandler.openUrl(paymentGatewayUri!);
      }
    });
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(_status!, _authority!, _paymentRequest,
        (isPaymentSuccess, refID, paymentRequest) {
      if (isPaymentSuccess) {
        print(refID);
      } else {
        print(_status);
      }
    });
  }
}
