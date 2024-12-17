import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repositories/hive_service.dart';
import '../../../home/data/models/my_product_response_model.dart';
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
        id: DateTime.now().millisecondsSinceEpoch,
        name: event.name,
        price: event.price,
        seller: Seller.SELLER_A,
        imageUrl: event.imagePath,
      );

      // Save to Hive
      final box =
          await HiveService.openBox<Product>(HiveService.productsBoxName);
      box.put(product.id, product);

      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure("Failed to add product: ${e.toString()}"));
    }
  }
}
