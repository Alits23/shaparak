abstract class CommentEvent {}

class CommentRequestList extends CommentEvent {
  String productId;
  int page;
  CommentRequestList(this.productId, this.page);
}

class CommentPostEvent extends CommentEvent {
  String comment;
  String productid;
  int page;
  CommentPostEvent(this.comment, this.productid,this.page);
}
