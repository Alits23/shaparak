import 'package:dio/dio.dart';
import 'package:shaparak/data/model/product.dart';
import 'package:shaparak/di/di.dart';

import '../../util/api_exception.dart';

abstract class IProductDatasource {
  Future<List<Product>> getProduct();
  Future<List<Product>> getProductHotest();
  Future<List<Product>> getProductBestSeller();
  Future<List<Product>> getProductList(String categoryId);
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

  @override
  Future<List<Product>> getProductHotest() async {
    Map<String, String> qParams = {'filter': 'popularity="Hotest"'};
    try {
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );
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

  @override
  Future<List<Product>> getProductBestSeller() async {
    Map<String, String> qParams = {'filter': 'popularity="Best Seller"'};
    try {
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );
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

  @override
  Future<List<Product>> getProductList(String categoryId) async {
    Map<String, String> qParams = {'filter': 'category="$categoryId"'};
    try {
      Response<dynamic> response;
      if (categoryId == 'qnbj8d6b9lzzpn8') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }
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
