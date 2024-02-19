import 'package:dartz/dartz.dart';
import 'package:shaparak/data/model/product.dart';

abstract class ProductListState {}

class ProductListInitState extends ProductListState {}

class ProductListLoadingState extends ProductListState {}

class ProductListResponseState extends ProductListState {
  Either<String, List<Product>> productList;
  ProductListResponseState(this.productList);
}
