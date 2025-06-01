import 'package:dio/dio.dart';
import 'package:weatherapp/Core/Network/url.dart';
import 'package:weatherapp/Core/Utils/log.dart';

// A service class to handle API calls using Dio package.
// Centralizes network request logic for the weather app.
class APIService {
  // Dio HTTP client instance used for making network requests.
  final Dio _dio = Dio();

  APIService() {
    // Configure Dio client with the base URL for all requests.
    _dio.options.baseUrl = URL.baseUrl;

    // Set connection timeout duration (how long to wait when establishing connection).
    _dio.options.connectTimeout = const Duration(seconds: 10);

    // Set receive timeout duration (how long to wait for response data).
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  /// Makes a GET request to the specified [path] with optional [queryParameters].
  /// Automatically adds API key to every request.
  /// Handles network errors and throws specific exceptions based on error type.
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      // Prepare query parameters by merging API key with any user-supplied parameters.
      final params = {
        'access_key': URL.apiKey,
        ...?queryParameters, // Spread operator to safely include queryParameters if not null.
      };

      // Make the GET request with the combined parameters.
      final response = await _dio.get(
        path,
        queryParameters: params,
      );

      // Return the response body (usually JSON decoded).
      return response.data;
    } on DioException catch (e, stackTrace) {
      // Log Dio-specific errors for debugging during development.
      AppLog().logMessage(message: "Dio Error: ${e.toString()}");
      AppLog().logMessage(message: "Dio Stacktrace: $stackTrace");

      // Customize error handling based on status code or Dio error type.
      if (e.response?.statusCode == 404) {
        // When server returns 404, likely invalid city/location.
        throw Exception('City not found');
      } else if (e.type == DioExceptionType.connectionTimeout ||
                 e.type == DioExceptionType.receiveTimeout) {
        // Timeout indicates network connectivity or server delay issues.
        throw Exception('Network timeout');
      } else {
        // Generic network error for other Dio exceptions.
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      // Catch-all for any other unexpected errors.
      AppLog().logMessage(message: "General Error: ${e.toString()}");
      throw Exception('Failed to fetch data');
    }
  }
}

