class ProductEntity {
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

  ProductEntity({
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
}

class Amount {
  String? amount;
  CurrencyCode? currencyCode;

  Amount({
    this.amount,
    this.currencyCode,
  });
}

enum CurrencyCode { USD }

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
}

enum Status { GOOD, NEW_WITHOUT_TAGS, NEW_WITH_TAGS, SATISFACTORY, VERY_GOOD }
