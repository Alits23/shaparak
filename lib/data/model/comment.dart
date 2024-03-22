class Comment {
  String id;
  String productid;
  String text;
  String userid;
  String? userThumbnailUrl;
  String username;
  String avatar;

  Comment(
    this.id,
    this.productid,
    this.text,
    this.userid,
    this.userThumbnailUrl,
    this.username,
    this.avatar,
  );

  factory Comment.fromMapjson(Map<String, dynamic> jsonObject) {
    return Comment(
      jsonObject['id'],
      jsonObject['product_id'],
      jsonObject['text'],
      jsonObject['user_id'],
      'https://startflutter.ir/api/files/${jsonObject['expand']['user_id']['collectionName']}/${jsonObject['expand']['user_id']['id']}/${jsonObject['expand']['user_id']['avatar']!}',
      jsonObject['expand']['user_id']['name'],
      jsonObject['expand']['user_id']['avatar'],
    );
  }
}
