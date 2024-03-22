abstract class CommentEvent {}

class CommentRequestList extends CommentEvent {
  String productId;
  CommentRequestList(this.productId);
}
