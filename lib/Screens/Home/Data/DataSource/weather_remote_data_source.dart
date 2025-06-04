import 'package:weatherapp/Core/Network/api_service.dart';
import 'package:weatherapp/Screens/Home/Domain/Model/weather_details_model.dart';

abstract class WeatherRemoteDataSource {
  // Fetches weather data from a remote source given a location.
  Future<WeatherDetailsModel> getWeatherData(String location);
}

// Responsible for making the actual API call via an injected APIService.
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  // An instance of a reusable API service class (e.g., built using Dio).
  final APIService _apiService;

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

