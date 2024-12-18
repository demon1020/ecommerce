import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repositories/hive_service.dart';
import '../../../home/data/models/product_model.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final HiveService hiveService;

  CheckoutBloc(this.hiveService) : super(CheckoutInitial()) {
    on<AddProductToCart>(_onAddProductToCart);
    on<LoadCart>(_onLoadCart);
  }

  Future<void> _onAddProductToCart(
      AddProductToCart event, Emitter<CheckoutState> emit) async {
    try {
      emit(CheckoutLoading());
      await hiveService.addProductToCart(event.product);
      final cartProducts = await hiveService.getCartProducts();
      emit(CheckoutLoaded(cartProducts));
    } catch (e) {
      emit(CheckoutError("Failed to add product to cart"));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CheckoutState> emit) async {
    try {
      emit(CheckoutLoading());
      final cartProducts = await hiveService.getCartProducts();
      emit(CheckoutLoaded(cartProducts));
    } catch (e) {
      emit(CheckoutError("Failed to load cart"));
    }
  }

  double calculateCartTotal(List<Product> cartProducts) {
    double total = 0.0;

    try {
      for (var product in cartProducts) {
        total += double.parse(product.price!.totalAmount!.amount!);
      }
    } catch (e) {
      return 0;
    }

    return total;
  }
}
