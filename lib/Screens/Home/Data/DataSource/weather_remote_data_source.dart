import 'package:weatherapp/Core/Network/api_service.dart';
import 'package:weatherapp/Screens/Home/Domain/Model/weather_details_model.dart';

// Abstract class that defines the contract for fetching weather data remotely.
// This allows multiple implementations (e.g., real API, mock for testing).
abstract class WeatherRemoteDataSource {
  // Fetches weather data from a remote source given a location.
  Future<WeatherDetailsModel> getWeatherData(String location);
}

// Concrete implementation of the WeatherRemoteDataSource.
// Responsible for making the actual API call via an injected APIService.
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  // An instance of a reusable API service class (e.g., built using Dio).
  final APIService _apiService;

  // Constructor that injects the APIService dependency.
  WeatherRemoteDataSourceImpl(this._apiService);

  @override
  Future<WeatherDetailsModel> getWeatherData(String location) async {
    try {
      // Make a GET request to the '/current' endpoint with the city/location as query.
      final response = await _apiService.get(
        '/current',
        queryParameters: {'query': location},
      );

      // Parse the JSON response into a WeatherDetailsModel object.
      return WeatherDetailsModel.fromJson(response);
    } catch (e) {
      // If any error occurs (e.g., network failure, invalid response), throw an exception.
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}

