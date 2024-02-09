class Product {
  String collectionId;
  String description;
  int discount_price;
  String id;
  String name;
  String popularity;
  int quantity;
  int price;
  String thumbnail;
  String category;

  Product(
    this.collectionId,
    this.description,
    this.discount_price,
    this.id,
    this.name,
    this.popularity,
    this.quantity,
    this.price,
    this.thumbnail,
    this.category,
  );

  factory Product.fromJson(Map<String, dynamic> jsonObject) {
    return Product(
      jsonObject['collectionId'],
      jsonObject['description'],
      jsonObject['discount_price'],
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['popularity'],
      jsonObject['quantity'],
      jsonObject['price'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['category'],
    );
  }
}
