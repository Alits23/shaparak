import 'package:shaparak/data/model/product.dart';

abstract class ProductEvent {}

class ProductRequestList extends ProductEvent {
  String productId;
  String categoryId;
  ProductRequestList(this.productId, this.categoryId);
}

class ProductAddToBasket extends ProductEvent {
  Product product;
  ProductAddToBasket(this.product);
}
