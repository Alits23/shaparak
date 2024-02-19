abstract class ProductListEvent {}

class ProductListRequest extends ProductListEvent {
  String categoryId;
  ProductListRequest(this.categoryId);
}
