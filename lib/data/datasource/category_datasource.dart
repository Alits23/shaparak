import 'package:dio/dio.dart';
import 'package:shaparak/di/di.dart';
import '../../util/api_exception.dart';
import '../model/category.dart';

abstract class IcategoryDatasource {
  Future<List<Category>> getCategories();
}

class CategoryDatasourceRemote extends IcategoryDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Category>> getCategories() async {
    try {
      var response = await _dio.get('collections/category/records');
      return response.data['items']
          .map<Category>((jsonObject) => Category.fromMapjson(jsonObject))
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
