import 'package:dio/dio.dart';
import 'package:shaparak/data/model/comment.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/api_exception.dart';

abstract class ICommentDatasource {
  Future<List<Comment>> getComment(String productid);
  Future<void> postComment(String comment, String productid);
}

class CommentDatasourceRemote extends ICommentDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Comment>> getComment(String productid) async {
    Map<String, String> qParams = {
      'filter': 'product_id="$productid"',
      'expand': 'user_id'
    };
    try {
      var response = await _dio.get('collections/comment/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapjson(jsonObject))
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
  Future<void> postComment(String comment, String productid) async {
    try {
      var response = await _dio.post(
        'collections/comment/records',
        data: {
          'text': comment,
          'user_id': 'qcft6hutapro7p6',
          'product_id': productid,
        },
      );
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['data']['username']['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
