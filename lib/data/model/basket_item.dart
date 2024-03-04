import 'package:hive_flutter/hive_flutter.dart';
part 'basket_item.g.dart';

@HiveType(typeId: 1)
class BasketItem {
  @HiveField(0)
  String collectionId;
  @HiveField(1)
  int? discount_price;
  @HiveField(2)
  String id;
  @HiveField(3)
  String name;
  @HiveField(4)
  int? price;
  @HiveField(5)
  String thumbnail;
  @HiveField(6)
  String category;
  @HiveField(7)
  num? persent;
  @HiveField(8)
  int? realPrice;

  BasketItem(
    this.collectionId,
    this.discount_price,
    this.id,
    this.name,
    this.price,
    this.thumbnail,
    this.category,
  ) {
    realPrice = price! - discount_price!;
    persent = ((price! + discount_price!) / price!) * 100 - 100;
  }
}
