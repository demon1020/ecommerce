import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repositories/hive_service.dart';
import '../../../home/data/models/product_model.dart';
import 'add_product_event.dart';
import 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductInitial()) {
    on<AddProductFormSubmitted>(_onFormSubmitted);
  }

  Future<void> _onFormSubmitted(
    AddProductFormSubmitted event,
    Emitter<AddProductState> emit,
  ) async {
    emit(AddProductLoading());

    try {
      // Create Product object
      final product = Product(
        productId: int.parse(
            DateTime.now().millisecondsSinceEpoch.toString().substring(0, 5)),
        title: event.name,
        image: event.imagePath,
        price: Price(totalAmount: Amount(amount: event.price.toString())),
        seller: Seller(username: "Ram"),
      );

      // Save to Hive
      final box =
          await HiveService.openBox<Product>(HiveService.productsBoxName);
      box.add(product);

      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure("Failed to add product: ${e.toString()}"));
    }
  }
}
