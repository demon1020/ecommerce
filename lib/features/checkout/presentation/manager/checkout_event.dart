import 'package:equatable/equatable.dart';

import '../../../home/data/models/product_model.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class AddProductToCart extends CheckoutEvent {
  final Product product;

  const AddProductToCart(this.product);

  @override
  List<Object> get props => [product];
}

class LoadCart extends CheckoutEvent {}
