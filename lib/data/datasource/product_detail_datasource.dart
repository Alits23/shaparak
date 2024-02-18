import 'package:dio/dio.dart';
import 'package:shaparak/data/model/category.dart';
import 'package:shaparak/data/model/product_image.dart';
import 'package:shaparak/data/model/properties.dart';
import 'package:shaparak/data/model/variant.dart';
import 'package:shaparak/data/model/variant_type.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/api_exception.dart';

import '../model/product_variant.dart';

abstract class IProductDetailDatasource {
  Future<List<ProductImage>> getProductImage(String productId);
  Future<List<VariantType>> getVarinatTypes();
  Future<List<Variant>> getVarinat(String productId);
  Future<List<ProductVariant>> getProductVarinat(String productId);
  Future<Category> getProductCategory(String categoryId);
  Future<List<Properties>> getProductProperties(String productId);
}

class ProductDetailDatasourceRemote extends IProductDetailDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getProductImage(String productId) async {
    Map<String, String> qParams = {'filter': 'product_id="$productId"'};
    try {
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams);
      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromjson(jsonObject))
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
  Future<List<VariantType>> getVarinatTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromJson(jsonObject))
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
  Future<List<Variant>> getVarinat(String productId) async {
    Map<String, String> qParams = {'filter': 'product_id="$productId"'};
    try {
      var response = await _dio.get('collections/variants/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
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
  Future<List<ProductVariant>> getProductVarinat(String productId) async {
    var variantTypeList = await getVarinatTypes();
    var variantList = await getVarinat(productId);
    List<ProductVariant> productVariantList = [];
    try {
      for (var variantType in variantTypeList) {
        var variant = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();

        productVariantList.add(ProductVariant(variantType, variant));
      }
      return productVariantList;
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
  Future<Category> getProductCategory(String categoryId) async {
    Map<String, String> qParams = {'filter': 'id="$categoryId"'};
    try {
      var response = await _dio.get('collections/category/records',
          queryParameters: qParams);
      return Category.fromMapjson(response.data['items'][0]);
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
  Future<List<Properties>> getProductProperties(String productId) async {
    Map<String, String> qParams = {'filter': 'product_id="$productId"'};
    try {
      var response = await _dio.get('collections/properties/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Properties>((jsonObject) => Properties.fromjson(jsonObject))
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
