import 'package:dartz/dartz.dart';
import 'package:shaparak/data/datasource/product_datasource.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/api_exception.dart';

abstract class IproductRepository {
  Future<Either<String, List<Product>>> getProduct();
}

class ProductRepository extends IproductRepository {
  final IProductDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Product>>> getProduct() async {
    try {
      var response = await _datasource.getProduct();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }
}
