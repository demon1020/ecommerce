import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repositories/hive_service.dart';
import '../../data/models/my_product_response_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  static const int itemsPerPage = 10;

  ProductBloc() : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
      LoadProductsEvent event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded && (state as ProductLoaded).hasReachedMax) {
      return; // No more data to load
    }

    try {
      emit(ProductLoading());

      // Simulate fetching paginated data
      final box =
          await HiveService.openBox<Product>(HiveService.productsBoxName);
      final allProducts = box.values.toList();
      final startIndex = (event.page - 1) * itemsPerPage;
      final endIndex = startIndex + itemsPerPage;

      final productsToLoad = allProducts.sublist(startIndex,
          endIndex > allProducts.length ? allProducts.length : endIndex);

      final hasReachedMax = productsToLoad.length < itemsPerPage;

      if (state is ProductLoaded) {
        final previousProducts = (state as ProductLoaded).products;
        emit(ProductLoaded(
            products: previousProducts + productsToLoad,
            hasReachedMax: hasReachedMax));
      } else {
        emit(ProductLoaded(
            products: productsToLoad, hasReachedMax: hasReachedMax));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
