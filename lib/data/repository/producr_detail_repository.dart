import 'package:dartz/dartz.dart';
import 'package:shaparak/data/datasource/product_detail_datasource.dart';
import 'package:shaparak/data/model/product_image.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/api_exception.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getProductImage();
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<ProductImage>>> getProductImage() async {
    try {
      var response = await _datasource.getProductImage();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }
}
