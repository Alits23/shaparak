import 'package:dartz/dartz.dart';
import 'package:shaparak/data/datasource/product_detail_datasource.dart';
import 'package:shaparak/data/model/product_image.dart';
import 'package:shaparak/data/model/product_variant.dart';
import 'package:shaparak/data/model/variant.dart';
import 'package:shaparak/data/model/variant_type.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/api_exception.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getProductImage(String productId);
  Future<Either<String, List<VariantType>>> getVariantType();
  Future<Either<String, List<ProductVariant>>> getproductVariants(
      String productId);
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<ProductImage>>> getProductImage(
      String productId) async {
    try {
      var response = await _datasource.getProductImage(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantType() async {
    try {
      var response = await _datasource.getVarinatTypes();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, List<Variant>>> getVariant(String productId) async {
    try {
      var response = await _datasource.getVarinat(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getproductVariants(
      String productId) async {
    try {
      var response = await _datasource.getProductVarinat(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }
}
