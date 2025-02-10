class ApiResponse {
  final int responseCode;
  final String successMessage;
  final Data data;

  ApiResponse({
    required this.responseCode,
    required this.successMessage,
    required this.data,
  });

  // Factory constructor for creating an instance from a map
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      responseCode: json['responseCode'],
      successMessage: json['successMessage'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final String message;
  final String otp;

  Data({
    required this.message,
    required this.otp,
  });

  // Factory constructor for creating an instance from a map
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json['message'],
      otp: json['otp'],
    );
  }
}
