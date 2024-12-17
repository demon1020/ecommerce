import 'package:equatable/equatable.dart';

import '../../../home/data/models/product_model.dart';

class ProfileState extends Equatable {
  final int itemsSold;
  final int itemsBought;
  final List<Product> productsListed;
  final List<Product> productsPurchased;

  ProfileState({
    required this.itemsSold,
    required this.itemsBought,
    required this.productsListed,
    required this.productsPurchased,
  });

  // Initial state with empty lists and zero counts
  factory ProfileState.initial() {
    return ProfileState(
      itemsSold: 0,
      itemsBought: 0,
      productsListed: [],
      productsPurchased: [],
    );
  }

  @override
  List<Object> get props =>
      [itemsSold, itemsBought, productsListed, productsPurchased];
}
