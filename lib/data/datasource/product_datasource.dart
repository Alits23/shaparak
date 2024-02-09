import 'package:dio/dio.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/di/di.dart';

import '../../util/api_exception.dart';

abstract class IProductDatasource {
  Future<List<Product>> getProduct();
}

class ProductDatasourceRemote extends IProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProduct() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
