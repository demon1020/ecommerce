import 'dart:convert';

class ProductResponseModel {
  int? productId;
  String? title;
  String? url;
  String? image;
  String? brand;
  String? size;
  Price? price;
  Seller? seller;

  ProductResponseModel({
    this.productId,
    this.title,
    this.url,
    this.image,
    this.brand,
    this.size,
    this.price,
    this.seller,
  });

  factory ProductResponseModel.fromRawJson(String str) =>
      ProductResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductResponseModel(
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

class Price {
  Amount? totalAmount;

  Price({
    this.totalAmount,
  });

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

class Amount {
  String? amount;

  Amount({
    this.amount,
  });

  factory Amount.fromRawJson(String str) => Amount.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}

enum CurrencyCode { USD }

final currencyCodeValues = EnumValues({"USD": CurrencyCode.USD});

class Seller {
  int? userId;
  String? username;
  String? profile;
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
