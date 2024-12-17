import 'package:ecommerce/features/home/data/models/product_model.dart';

import '../../../../core.dart';
import '../repositories/home_repository.dart';

class ProductUseCase {
  final HomeRepository repository;

  ProductUseCase(this.repository);

  //Can add additional validations
  Future<Either<AppException, List<Product>>> execute(dynamic request) async {
    return await repository.fetchProductList(request);
  }
}
