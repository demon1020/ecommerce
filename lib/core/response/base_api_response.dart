class BaseApiResponse<T> {
  final bool status;
  final String message;
  final T? data; // Nullable data
  final dynamic error; // Nullable error

  BaseApiResponse({
    required this.status,
    required this.message,
    this.data,
    this.error,
  });

  // Factory constructor to create an instance from a JSON object
  factory BaseApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return BaseApiResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data']) // Deserialize generic type if present
          : null,
      error: json['error'], // Directly assign error, can be null
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
      'error': error,
    };
  }
}
