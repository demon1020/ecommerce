import 'dart:convert';

class ProductResponseModel {
  int? productId;
  String? title;
  String? url;
  String? image;
  bool? promoted;
  int? favourites;
  String? brand;
  String? size;
  Price? price;
  Seller? seller;
  dynamic isSold;
  Status? status;

  ProductResponseModel({
    this.productId,
    this.title,
    this.url,
    this.image,
    this.promoted,
    this.favourites,
    this.brand,
    this.size,
    this.price,
    this.seller,
    this.isSold,
    this.status,
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
        promoted: json["promoted"],
        favourites: json["favourites"],
        brand: json["brand"],
        size: json["size"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        isSold: json["isSold"],
        status: statusValues.map[json["status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "title": title,
        "url": url,
        "image": image,
        "promoted": promoted,
        "favourites": favourites,
        "brand": brand,
        "size": size,
        "price": price?.toJson(),
        "seller": seller?.toJson(),
        "isSold": isSold,
        "status": statusValues.reverse[status],
      };
}

class Price {
  Amount? amount;
  dynamic currency;
  dynamic discount;
  Amount? fees;
  Amount? totalAmount;

  Price({
    this.amount,
    this.currency,
    this.discount,
    this.fees,
    this.totalAmount,
  });

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"] == null ? null : Amount.fromJson(json["amount"]),
        currency: json["currency"],
        discount: json["discount"],
        fees: json["fees"] == null ? null : Amount.fromJson(json["fees"]),
        totalAmount: json["totalAmount"] == null
            ? null
            : Amount.fromJson(json["totalAmount"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount?.toJson(),
        "currency": currency,
        "discount": discount,
        "fees": fees?.toJson(),
        "totalAmount": totalAmount?.toJson(),
      };
}

class Amount {
  String? amount;
  CurrencyCode? currencyCode;

  Amount({
    this.amount,
    this.currencyCode,
  });

  factory Amount.fromRawJson(String str) => Amount.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        amount: json["amount"],
        currencyCode: currencyCodeValues.map[json["currency_code"]]!,
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency_code": currencyCodeValues.reverse[currencyCode],
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

enum Status { GOOD, NEW_WITHOUT_TAGS, NEW_WITH_TAGS, VERY_GOOD }

final statusValues = EnumValues({
  "Good": Status.GOOD,
  "New without tags": Status.NEW_WITHOUT_TAGS,
  "New with tags": Status.NEW_WITH_TAGS,
  "Very good": Status.VERY_GOOD
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
