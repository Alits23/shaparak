import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/comment/comment_event.dart';
import 'package:shaparak/bloc/comment/comment_state.dart';
import 'package:shaparak/data/repository/comment_repository.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  ICommentRepository repository;
  CommentBloc(this.repository) : super(CommentLoadingState()) {
    on<CommentRequestList>((event, emit) async {
      var getComment = await repository.getComment(event.productId);
      emit(CommentResponseState(getComment));
    });
  }
}
