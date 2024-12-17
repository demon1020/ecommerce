import 'dart:convert';

import 'package:hive/hive.dart';

part 'my_product_response_model.g.dart';

@HiveType(typeId: 0)
class MyProductResponseModel {
  @HiveField(0)
  int? page;

  @HiveField(1)
  List<Product>? products;

  MyProductResponseModel({
    this.page,
    this.products,
  });

  factory MyProductResponseModel.fromRawJson(String str) =>
      MyProductResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyProductResponseModel.fromJson(Map<String, dynamic> json) =>
      MyProductResponseModel(
        page: json["page"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  int? price;

  @HiveField(3)
  Seller? seller;

  @HiveField(4)
  String? imageUrl;

  Product({
    this.id,
    this.name,
    this.price,
    this.seller,
    this.imageUrl,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        seller: sellerValues.map[json["seller"]]!,
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "seller": sellerValues.reverse[seller],
        "imageUrl": imageUrl,
      };
}

@HiveType(typeId: 2)
enum Seller {
  @HiveField(0)
  SELLER_A,

  @HiveField(1)
  SELLER_B,
}

final sellerValues = EnumValues({
  "Seller A": Seller.SELLER_A,
  "Seller B": Seller.SELLER_B,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
