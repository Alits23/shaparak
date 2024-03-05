import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/card/card_event.dart';
import 'package:shaparak/bloc/card/card_state.dart';

import '../../data/repository/basket_repository.dart';
import '../../di/di.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final IBasketRepository _basketRepository = locator.get();
  CardBloc() : super(CardInitState()) {
    on<CardRequestDataEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItem();
      var finalPrice = await _basketRepository.getBasketFinalPrice();
      emit(CardResponsState(
        basketItemList,
        finalPrice,
      ));
    });
  }
}
