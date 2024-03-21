import 'package:dartz/dartz.dart';
import 'package:shaparak/data/model/category.dart';
import 'package:shaparak/data/model/comment.dart';
import 'package:shaparak/data/model/product_image.dart';
import 'package:shaparak/data/model/product_variant.dart';
import 'package:shaparak/data/model/properties.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariant;
  Either<String, Category> categoryId;
  Either<String, List<Properties>> productProperties;
  Either<String, List<Comment>> getComment;

  ProductResponseState(
    this.productImages,
    this.productVariant,
    this.categoryId,
    this.productProperties,
    this.getComment,
  );
}
