import 'package:ecommerce/features/home/data/models/product_response_model.dart';

import '../../../../core.dart';

class HomeRemoteDataSource {
  final BaseApiServices _apiServices;

  HomeRemoteDataSource(this._apiServices);

  Future<Either<AppException, List<ProductResponseModel>>> fetchProductList(
      dynamic request) async {
    return await _apiServices.getApi(
      ApiUrl.productsApi,
      {"x-rapidapi-key": "a3326c45d7msh893a5b8de13f51bp12d083jsnf71b128614d8"},
      Parser.parseProductResponse,
      // body: request.toJson(),
    );
  }
}
