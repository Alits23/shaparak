abstract class ProductEvent {}

class ProductRequestList extends ProductEvent {
  String productId;
  String categoryId;
  ProductRequestList(this.productId, this.categoryId);
}
