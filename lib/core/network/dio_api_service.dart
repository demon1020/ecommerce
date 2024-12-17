import '/core.dart';

Duration apiTimeOut = const Duration(seconds: 60);

class NetworkApiService extends BaseApiServices {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.host));
  final connectivity = sl<ConnectivityServiceRepositoryImpl>();

  NetworkApiService() {
    _dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: false,
    ));
  }

  @override
  Future<Either<AppException, Q>> getApi<Q, R>(String apiURL,
      Map<String, String> headers, ComputeCallback<String, R> callback,
      {disableTokenValidityCheck = false}) async {
    try {
      await connectivity.ensureInternetConnectivity();
      // await checkForValidSession(disableTokenValidityCheck);
      Options options = Options(
        headers: headers,
        responseType: ResponseType.json,
      );

      Response response = await _dio
          .get(
            apiURL,
            options: options,
          )
          .timeout(apiTimeOut);

      return Parser.parseResponse(response, callback);
    } on DioException catch (e) {
      AppException appException = Failure.handleDioError(e);
      return Left(appException);
    }
  }

  @override
  Future<Either<AppException, Q>> postApi<Q, R>(String apiURL,
      Map<String, String> headers, ComputeCallback<String, R> callback,
      {body, disableTokenValidityCheck = false}) async {
    try {
      var requestBody = jsonEncode(body);
      await connectivity.ensureInternetConnectivity();

      // await checkForValidSession(disableTokenValidityCheck);

      Options options = Options(
        headers: headers,
        responseType: ResponseType.json,
      );

      Response response = await _dio
          .post(
            apiURL,
            data: requestBody,
            options: options,
          )
          .timeout(apiTimeOut);

      return Parser.parseResponse(response, callback);
    } on DioException catch (e) {
      AppException appException = Failure.handleDioError(e);
      return Left(appException);
    }
  }

  @override
  Future<Either<AppException, Q>> multipartApi<Q, R>(String apiURL,
      Map<String, String> headers, ComputeCallback<String, R> callback,
      {body,
      required String path,
      required String imageFieldName,
      disableTokenValidityCheck = false}) async {
    try {
      await connectivity.ensureInternetConnectivity();
      // await checkForValidSession(disableTokenValidityCheck);

      FormData formData = FormData();
      if (path.isNotEmpty) {
        formData.files
            .add(MapEntry(imageFieldName, await MultipartFile.fromFile(path)));
      }

      if (body != null) {
        body.forEach((key, value) {
          if (value != null) {
            formData.fields.add(MapEntry(key, value.toString()));
          }
        });
      }

      Options options = Options(
        headers: headers,
        responseType: ResponseType.json,
      );

      Response response = await _dio
          .post(
            apiURL,
            data: formData,
            options: options,
          )
          .timeout(apiTimeOut);

      return Parser.parseResponse(response, callback);
    } on DioException catch (e) {
      AppException appException = Failure.handleDioError(e);
      return Left(appException);
    }
  }
}
