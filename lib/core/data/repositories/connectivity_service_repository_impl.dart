import '/core.dart';

class ConnectivityServiceRepositoryImpl {
  final Connectivity _connectivity;

  // Inject the dependency via constructor for better testability
  ConnectivityServiceRepositoryImpl({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  // Method returns a Future<bool>, useful for immediate checks
  Future<bool> hasInternetConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Method that throws a custom error if there's no connectivity
  Future<void> ensureInternetConnectivity() async {
    if (!await hasInternetConnection()) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: "No Internet Connection",
        type: DioExceptionType.connectionError,
      );
    }
  }
}
