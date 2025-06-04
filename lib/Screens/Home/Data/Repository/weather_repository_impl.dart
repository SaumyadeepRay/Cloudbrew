import 'package:weatherapp/Core/Utils/log.dart';
import 'package:weatherapp/Screens/Home/Data/DataSource/weather_remote_data_source.dart';
import 'package:weatherapp/Screens/Home/Domain/Model/weather_details_model.dart';
import 'package:weatherapp/Screens/Home/Domain/Repository/weather_repository.dart';

// Concrete implementation of the abstract WeatherRepository.
// This class is responsible for fetching weather data from a remote data source (e.g., API).
class WeatherRepositoryImpl implements WeatherRepository {
  // Reference to the remote data source, which actually performs the API call.
  final WeatherRemoteDataSource _remoteDataSource;

  // Constructor that takes in a remote data source.
  // This allows dependency injection and supports mocking for testing.
  WeatherRepositoryImpl(this._remoteDataSource);

  // Implements the getWeather method from the abstract repository.
  // This method calls the remote data source to fetch weather data for the given location.
  @override
  Future<WeatherDetailsModel> getWeather({String? location}) async {
    try {
      // Fetch the weather data using the remote data source and return it.
      return await _remoteDataSource.getWeatherData(location!);
    } catch (e) {
      // Log the error for debugging and observability purposes.
      AppLog().logMessage(message: 'Repository error: $e');
      // Rethrow the error to let the upper layers (e.g., Bloc) handle it properly.
      rethrow;
    }
  }
}

