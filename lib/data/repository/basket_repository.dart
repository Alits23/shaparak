import 'package:dartz/dartz.dart';
import 'package:shaparak/data/datasource/basket_datasource.dart';
import 'package:shaparak/data/model/basket_item.dart';
import 'package:shaparak/di/di.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItem();
  Future<int> getBasketFinalPrice();
  Future<void> removeProduct(int index);
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

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItem() async {
    try {
      var basketItemList = await _datasource.getAllBasketItem();
      return right(basketItemList);
    } catch (e) {
      return left('خطا در نمایش محصولات');
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    return _datasource.getBasketFinalPrice();
  }

  @override
  Future<void> removeProduct(int index) async {
    _datasource.removeProduct(index);
  }
}
