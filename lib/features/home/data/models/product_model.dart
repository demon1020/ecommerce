import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  int? productId;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? url;

  @HiveField(3)
  String? image;

  @HiveField(4)
  String? brand;

  @HiveField(5)
  String? size;

  @HiveField(6)
  Price? price;

  @HiveField(7)
  Seller? seller;

  Product({
    this.productId,
    this.title,
    this.url,
    this.image,
    this.brand,
    this.size,
    this.price,
    this.seller,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        title: json["title"],
        url: json["url"],
        image: json["image"],
        brand: json["brand"],
        size: json["size"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "title": title,
        "url": url,
        "image": image,
        "brand": brand,
        "size": size,
        "price": price?.toJson(),
        "seller": seller?.toJson(),
      };
}

@HiveType(typeId: 1)
class Price {
  @HiveField(0)
  Amount? totalAmount;

  Price({this.totalAmount});

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        totalAmount: json["totalAmount"] == null
            ? null
            : Amount.fromJson(json["totalAmount"]),
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount?.toJson(),
      };
}

@HiveType(typeId: 2)
class Amount {
  @HiveField(0)
  String? amount;

  Amount({this.amount});

  factory Amount.fromRawJson(String str) => Amount.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}

@HiveType(typeId: 3)
class Seller {
  @HiveField(0)
  int? userId;

  @HiveField(1)
  String? username;

  @HiveField(2)
  String? profile;

  @HiveField(3)
  String? profilePicture;

  Seller({
    this.userId,
    this.username,
    this.profile,
    this.profilePicture,
  });

  factory Seller.fromRawJson(String str) => Seller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        userId: json["userId"],
        username: json["username"],
        profile: json["profile"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "profile": profile,
        "profilePicture": profilePicture,
      };
}

// Enum for currency code
enum CurrencyCode { USD }

final currencyCodeValues = EnumValues({"USD": CurrencyCode.USD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
