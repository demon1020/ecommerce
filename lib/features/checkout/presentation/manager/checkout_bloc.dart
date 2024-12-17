import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/models/product_model.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutState(cart: [], totalAmount: 0));

  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is AddProductToCart) {
      final updatedCart = List<Product>.from(state.cart)..add(event.product);
      final updatedTotalAmount = _calculateTotalAmount(updatedCart);
      yield state.copyWith(cart: updatedCart, totalAmount: updatedTotalAmount);
    } else if (event is RemoveProductFromCart) {
      final updatedCart = List<Product>.from(state.cart)..remove(event.product);
      final updatedTotalAmount = _calculateTotalAmount(updatedCart);
      yield state.copyWith(cart: updatedCart, totalAmount: updatedTotalAmount);
    } else if (event is Checkout) {
      // Handle the checkout (mock process)
      yield CheckoutState(
          cart: [], totalAmount: 0); // Reset the cart after checkout
    }
  }

  int _calculateTotalAmount(List<Product> cart) {
    return cart.fold(
        0,
        (sum, product) =>
            sum + (int.parse(product.price!.totalAmount!.amount!) ?? 0));
  }
}
