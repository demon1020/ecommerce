import 'package:equatable/equatable.dart';

import '../../../home/data/models/product_model.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final List<Product> cartProducts;

  const CheckoutLoaded(this.cartProducts);

  @override
  List<Object> get props => [cartProducts];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError(this.message);

  @override
  List<Object> get props => [message];
}

class CheckoutSuccess extends CheckoutState {
  final List<Product> cartProducts;

  const CheckoutSuccess(this.cartProducts);

  @override
  List<Object> get props => [cartProducts];
}
