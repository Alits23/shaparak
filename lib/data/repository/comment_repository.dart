import 'package:dartz/dartz.dart';
import 'package:shaparak/data/datasource/comment_datasource.dart';
import 'package:shaparak/data/model/comment.dart';
import 'package:shaparak/di/di.dart';
import 'package:shaparak/util/api_exception.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComment(String productid,int page);
  Future<Either<String, String>> postComment(String comment, String productid);
}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Comment>>> getComment(String productid,int page) async {
    try {
      var response = await _datasource.getComment(productid,page);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String comment, String productid) async {
    try {
      // ignore: unused_local_variable
      var response = await _datasource.postComment(comment, productid);
      return right('نظر شما ثبت شد');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای ناشناخته');
    }
  }
}
