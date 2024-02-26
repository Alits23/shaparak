import 'package:hive_flutter/hive_flutter.dart';
import 'package:shaparak/data/model/basket_item.dart';

abstract class IBasketDatasource {
  Future<void> addProduct(BasketItem basketItem);
}

class BasketLocalDataSource extends IBasketDatasource {
  var cardBox = Hive.box<BasketItem>('BasketItem');
  @override
  Future<void> addProduct(BasketItem basketItem) async {
    cardBox.add(basketItem);
  }
}
