// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasketItemAdapter extends TypeAdapter<BasketItem> {
  @override
  final int typeId = 1;

  @override
  BasketItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasketItem(
      fields[0] as String,
      fields[1] as int?,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int?,
      fields[5] as String,
      fields[6] as String,
    )
      ..persent = fields[7] as num?
      ..realPrice = fields[8] as int?;
  }

  @override
  void write(BinaryWriter writer, BasketItem obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.collectionId)
      ..writeByte(1)
      ..write(obj.discount_price)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.thumbnail)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.persent)
      ..writeByte(8)
      ..write(obj.realPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
