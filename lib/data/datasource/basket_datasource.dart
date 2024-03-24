import 'package:hive_flutter/hive_flutter.dart';
import 'package:shaparak/data/model/basket_item.dart';

abstract class IBasketDatasource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItem();
  Future<int> getBasketFinalPrice();
  Future<void> removeProduct(int index);
}

class BasketLocalDataSource extends IBasketDatasource {
  var cardBox = Hive.box<BasketItem>('BasketItem');
  @override
  Future<void> addProduct(BasketItem basketItem) async {
    cardBox.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItem() async {
    return cardBox.values.toList();
  }

  @override
  Future<int> getBasketFinalPrice() async {
    List<BasketItem> productList = cardBox.values.toList();
    int finalPrice = productList.fold(
        0, (accumulatoe, product) => accumulatoe + product.realPrice!);
    return finalPrice;
  }

  @override
  Future<void> removeProduct(int index) async {
    cardBox.deleteAt(index);
  }
}
