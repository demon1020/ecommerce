import 'package:ecommerce/features/home/data/models/product_model.dart';

import '../../core.dart';
// import '../../features/login/data/models/login_response_model.dart';

class Parser {
  // Parse response using Dio and custom exceptions
  static Future<Either<AppException, Q>> parseResponse<Q, R>(
      Response response, ComputeCallback<String, R> callback) async {
    String message = "";

    try {
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            dynamic result = await compute(callback, response.data.toString());
            return Right(result as Q);
          }

        default:
          return Left(UnknownError());
      }
    } catch (e) {
      // Handle error scenarios like JSON parsing errors
      return Left(UnknownError());
    }
  }

  static Future<List<Product>> parseProductResponse(String responseBody) async {
    final List<dynamic> jsonData = json.decode(responseBody);
    return jsonData.map((data) => Product.fromJson(data)).toList();
  }
}
