import 'package:ecommerce/features/home/data/models/product_model.dart';
import 'package:ecommerce/features/home/domain/use_cases/product_use_case.dart';

import '../../../../core.dart';
import 'home_event.dart';
import 'home_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  static const int itemsPerPage = 10;
  final ProductUseCase productUseCase;
  bool loaded = false;
  List<Product> allProducts = [];

  ProductBloc(this.productUseCase) : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<SearchProductsEvent>(_onSearchProducts); // Handle search event.
  }

  Future<void> _onLoadProducts(
      LoadProductsEvent event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded && (state as ProductLoaded).hasReachedMax) {
      return; // No more data to load
    }

    try {
      emit(ProductLoading());

      Either<AppException, List<Product>> result =
          await productUseCase.execute(event.page.toString());

      result.fold(
        (l) => emit(ProductError(l.message)),
        (r) {
          allProducts.addAll([...r]);
          if (loaded) {
            emit(ProductLoaded(products: r, hasReachedMax: false));
          } else {
            emit(ProductLoaded(products: [...r], hasReachedMax: false));
          }

          loaded = true;
        },
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
      SearchProductsEvent event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded) {
      final query = event.query.toLowerCase();
      final filteredProducts = allProducts.where((product) {
        final title = product.title?.toLowerCase() ?? '';
        return title.contains(query);
      }).toList();

      emit(ProductLoaded(
          products: filteredProducts,
          hasReachedMax: true)); // Emit filtered results.
    }
  }
}
