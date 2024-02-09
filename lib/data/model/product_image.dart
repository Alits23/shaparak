class ProductImage {
  String collectionId;
  String collectionName;
  String id;
  String image;
  String product_id;

  ProductImage(
    this.collectionId,
    this.collectionName,
    this.id,
    this.image,
    this.product_id,
  );

  factory ProductImage.fromjson(Map<String, dynamic> jsonObject) {
    return ProductImage(
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      jsonObject['id'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
      jsonObject['product_id'],
    );
  }
}
