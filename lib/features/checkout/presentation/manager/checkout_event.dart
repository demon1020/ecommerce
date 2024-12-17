import 'package:equatable/equatable.dart';

import '../../../home/data/models/product_model.dart';

abstract class CheckoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddProductToCart extends CheckoutEvent {
  final Product product;

  AddProductToCart(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveProductFromCart extends CheckoutEvent {
  final Product product;

  RemoveProductFromCart(this.product);

  @override
  List<Object?> get props => [product];
}

class Checkout extends CheckoutEvent {}
