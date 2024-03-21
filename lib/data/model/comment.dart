class Comment {
  String id;
  String productid;
  String text;
  String userid;

  Comment(
    this.id,
    this.productid,
    this.text,
    this.userid,
  );

  factory Comment.fromMapjson(Map<String, dynamic> jsonObject) {
    return Comment(
      jsonObject['id'],
      jsonObject['product_id'],
      jsonObject['text'],
      jsonObject['user_id'],
    );
  }
}
