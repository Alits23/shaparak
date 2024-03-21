import 'package:dartz/dartz.dart';
import 'package:shaparak/data/datasource/comment_datasource.dart';
import 'package:shaparak/data/model/comment.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/api_exception.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComment(String productid);
}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Comment>>> getComment(String productid) async {
    try {
      var response = await _datasource.getComment(productid);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }
}
