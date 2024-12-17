import 'package:ecommerce/features/home/data/models/product_response_model.dart';

import '/core.dart';

abstract class HomeRepository {
  Future<Either<AppException, List<ProductResponseModel>>> fetchProductList(
      dynamic request);
}
