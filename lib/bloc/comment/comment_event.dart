abstract class CommentEvent {}

class CommentRequestList extends CommentEvent {
  String productId;
  CommentRequestList(this.productId);
}

class CommentPostEvent extends CommentEvent {
  String comment;
  String productid;
  CommentPostEvent(this.comment, this.productid);
}
