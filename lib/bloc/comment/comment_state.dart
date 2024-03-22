import 'package:dartz/dartz.dart';
import 'package:shaparak/data/model/comment.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResponseState extends CommentState {
  Either<String, List<Comment>> getComment;
  CommentResponseState(this.getComment);
}

class CommentPostLoadingState extends CommentState {
  final bool isLoading;
  CommentPostLoadingState(this.isLoading);
}

class CommentPostResponseState extends CommentState {
  Either<String, String> postComment;
  CommentPostResponseState(this.postComment);
}
