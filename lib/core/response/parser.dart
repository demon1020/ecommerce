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
            dynamic result = await compute(callback, jsonEncode(response.data));
            if (result.status == false) {
              message = response.data["message"] ?? "";
              return Left(
                ValidationError(
                  statusCode: response.statusCode,
                  message: message,
                ),
              );
            }
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

  // Parse login response with Dio (can be customized for other responses as needed)
  // static Future<BaseApiResponse<LoginResponseModel>> parseLogInResponse(
  //     String responseBody) async {
  //   return BaseApiResponse<LoginResponseModel>.fromJson(
  //     jsonDecode(responseBody),
  //     (data) => LoginResponseModel.fromJson(data),
  //   );
  // }
}
