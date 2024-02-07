class Category {
  String? collectionId;
  String? color;
  String? icon;
  String? id;
  String? thumbnail;
  String? title;

  Category(
    this.collectionId,
    this.color,
    this.icon,
    this.id,
    this.thumbnail,
    this.title,
  );

  factory Category.fromMapjson(Map<String, dynamic> jsonObject) {
    return Category(
      jsonObject['collectionId'],
      jsonObject['color'],
      jsonObject['icon'],
      jsonObject['id'],
      jsonObject['thumbnail'],
      jsonObject['title'],
    );
  }
}
