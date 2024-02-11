import 'package:dartz/dartz.dart';
import 'package:shaparak/data/model/product_image.dart';
import 'package:shaparak/data/model/product_variant.dart';
import 'package:shaparak/data/model/variant.dart';
import 'package:shaparak/data/model/variant_type.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariant;

  ProductResponseState(
    this.productImages,
    this.productVariant,
  );
}
