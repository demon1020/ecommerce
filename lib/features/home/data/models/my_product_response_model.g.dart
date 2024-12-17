// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_product_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyProductResponseModelAdapter
    extends TypeAdapter<MyProductResponseModel> {
  @override
  final int typeId = 0;

  @override
  MyProductResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyProductResponseModel(
      page: fields[0] as int?,
      products: (fields[1] as List?)?.cast<Product>(),
    );
  }

  @override
  void write(BinaryWriter writer, MyProductResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyProductResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as int?,
      name: fields[1] as String?,
      price: fields[2] as int?,
      seller: fields[3] as Seller?,
      imageUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.seller)
      ..writeByte(4)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SellerAdapter extends TypeAdapter<Seller> {
  @override
  final int typeId = 2;

  @override
  Seller read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Seller.SELLER_A;
      case 1:
        return Seller.SELLER_B;
      default:
        return Seller.SELLER_A;
    }
  }

  @override
  void write(BinaryWriter writer, Seller obj) {
    switch (obj) {
      case Seller.SELLER_A:
        writer.writeByte(0);
        break;
      case Seller.SELLER_B:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SellerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
