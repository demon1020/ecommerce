import 'package:equatable/equatable.dart';

import '../../../home/data/models/product_model.dart';

class CheckoutState extends Equatable {
  final List<Product> cart;
  final int totalAmount;

  CheckoutState({required this.cart, required this.totalAmount});

  CheckoutState copyWith({
    List<Product>? cart,
    int? totalAmount,
  }) {
    return CheckoutState(
      cart: cart ?? this.cart,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [cart, totalAmount];
}
