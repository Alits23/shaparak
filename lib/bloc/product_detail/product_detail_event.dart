abstract class ProductEvent {}

class ProductRequestList extends ProductEvent {
  String productId;
  ProductRequestList(this.productId);
}
