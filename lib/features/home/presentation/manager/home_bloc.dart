import 'package:ecommerce/features/home/data/models/product_model.dart';
import 'package:ecommerce/features/home/domain/use_cases/product_use_case.dart';

import '../../../../core.dart';
import 'home_event.dart';
import 'home_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  static const int itemsPerPage = 10;
  final ProductUseCase productUseCase;
  bool loaded = false;

  ProductBloc(this.productUseCase) : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
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
}
