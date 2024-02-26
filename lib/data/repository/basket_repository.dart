import 'package:dartz/dartz.dart';
import 'package:shaparak/data/datasource/basket_datasource.dart';
import 'package:shaparak/data/model/basket_item.dart';
import 'package:shaparak/di/di.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
}

class BasketRepository extends IBasketRepository {
  final IBasketDatasource _datasource = locator.get();
  @override
  Future<Either<String, String>> addProductToBasket(
      BasketItem basketItem) async {
    try {
      _datasource.addProduct(basketItem);
      return right('محصول به سبد خرید اضافه شد');
    } catch (e) {
      return left('خطا در افزودن محصول به سبد خرید');
    }
  }
}
