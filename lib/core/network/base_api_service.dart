import '/core.dart';

abstract class BaseApiServices {
  Future<Either<AppException, Q>> postApi<Q, R>(
    String apiURL,
    Map<String, String> headers,
    ComputeCallback<String, R> callback, {
    body,
    disableTokenValidityCheck = false,
  });

  Future<Either<AppException, Q>> getApi<Q, R>(
    String apiURL,
    Map<String, String> headers,
    ComputeCallback<String, R> callback, {
    disableTokenValidityCheck = false,
  });

  Future<Either<AppException, Q>> multipartApi<Q, R>(
    String apiURL,
    Map<String, String> headers,
    ComputeCallback<String, R> callback, {
    body,
    required String path,
    required String imageFieldName,
    disableTokenValidityCheck = true,
  });
}
