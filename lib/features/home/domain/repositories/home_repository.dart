import 'package:ecommerce/features/home/data/models/product_model.dart';

import '/core.dart';

abstract class HomeRepository {
  Future<Either<AppException, List<Product>>> fetchProductList(dynamic request);
}
