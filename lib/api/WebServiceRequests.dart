import 'package:dio/dio.dart';

class WebServiceRequests {
  static final WebServiceRequests instance = WebServiceRequests._internal();
  factory WebServiceRequests() => instance;

  WebServiceRequests._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://13.232.65.213:8085/api/",
        headers: {
          "X-Api-Key": "WUS-IOT-api-key-2024",
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  late Dio _dio;
  final String headerApiKey = "WUS-IOT-api-key-2024";

  /// Request to Generate OTP
  Future<Response> otp(String mobile) async {
    try {
      final response = await _dio.post(
        "auth/generate-otp",
        data: {"mobileNumber": mobile},
      );
      return response;
    } catch (e) {
      return Future.error("Error generating OTP: $e");
    }
  }

  /// Request to Verify OTP
  Future<Response> otpVerify(String mobile, String otp) async {
    try {
      final response = await _dio.post(
        "auth/verify-otp",
        data: {
          "mobileNumber": mobile,
          "otp": otp,
        },
      );
      return response;
    } catch (e) {
      return Future.error("Error verifying OTP: $e");
    }
  }

  /// Get Worker Details
  Future<Response> getWorkerDetails(int userId) async {
    try {
      final response = await _dio.post(
        "worker/get-workers-details",
        data: {"UserId": userId},
      );
      return response;
    } catch (e) {
      return Future.error("Error fetching worker details: $e");
    }
  }

  /// Get Worker List
  Future<Response> getWorkerList(int userId) async {
    try {
      final response = await _dio.post(
        "worker/get-workers",
        data: {"UserId": userId},
      );
      return response;
    } catch (e) {
      return Future.error("Error fetching worker list: $e");
    }
  }

  /// Get Device by Type
  Future<Response> getDeviceByType(int typeId) async {
    try {
      final response = await _dio.get(
        "worker/GetDevicesByType/$typeId",
      );
      return response;
    } catch (e) {
      return Future.error("Error fetching device type: $e");
    }
  }

  /// Add/Update Worker
  Future<Response> addUpdateWorker({
    required int userId,
    required String uname,
    required String dob,
    required String mobileNum,
    required String address,
    required int age,
    required String location,
    required int kawachId,
    required int watchId,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "userId": userId,
        "name": uname,
        "mobile": mobileNum,
        "email": "amitpal@gmail.com",
        "kawachDeviceId": kawachId,
        "watchDeviceId": watchId,
        "age": age,
        "workArea": location,
        "dob": dob,
        "address": address,
      });

      final response = await _dio.post("worker/addOrUpdateUser", data: formData);
      return response;
    } catch (e) {
      return Future.error("Error adding/updating worker: $e");
    }
  }


  /*const val AddDeviceDetails = "auth/add-device-details"
  const val DeviceTypes = "worker/GetDeviceTypes"*/
}
