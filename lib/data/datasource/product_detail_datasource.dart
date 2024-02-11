import 'package:dio/dio.dart';
import 'package:shaparak/data/model/product_image.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/api_exception.dart';

abstract class IProductDetailDatasource {
  Future<List<ProductImage>> getProductImage(String productId);
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
}
