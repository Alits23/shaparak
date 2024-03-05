import 'package:dartz/dartz.dart';
import 'package:shaparak/data/model/basket_item.dart';

abstract class CardState {}

class CardInitState extends CardState {}

class CardResponsState extends CardState {
  Either<String, List<BasketItem>> basketItemList;
  int basketFinalPrice;
  CardResponsState(
    this.basketItemList,
    this.basketFinalPrice,
  );
}
