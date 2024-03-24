import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/card/card_event.dart';
import 'package:shaparak/bloc/card/card_state.dart';
import 'package:shaparak/util/payment_handler.dart';

import '../../data/repository/basket_repository.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final IBasketRepository _basketRepository;
  final PaymentHandler _paymentHandler;
  CardBloc(this._paymentHandler, this._basketRepository)
      : super(CardInitState()) {
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
        var finalPrice = await _basketRepository.getBasketFinalPrice();
        _paymentHandler.initPaymentRequest(finalPrice);
      },
    );

    on<CardPaymentRequestEvent>(
      (event, emit) async {
        _paymentHandler.sendPaymentRequest();
      },
    );

    on<CardRemoveProductEvent>((event, emit) async {
      _basketRepository.removeProduct(event.index);
      var basketItemList = await _basketRepository.getAllBasketItem();
      var finalPrice = await _basketRepository.getBasketFinalPrice();
      emit(CardResponsState(
        basketItemList,
        finalPrice,
      ));
    });
  }
}
