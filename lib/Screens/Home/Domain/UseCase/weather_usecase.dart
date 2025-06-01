import 'package:weatherapp/Screens/Home/Domain/Model/weather_details_model.dart';
import 'package:weatherapp/Screens/Home/Domain/Repository/weather_repository.dart';

// The Usecase layer acts as an abstraction between the UI/business logic and the repository.
// It contains the core application logic related to fetching weather details.
class WeatherUsecase {
  final WeatherRepository _repository;

  // Constructor to inject the required repository.
  WeatherUsecase(this._repository);

  // Method to get weather details for a given location.
  // If no location is provided, defaults to "Kolkata".
  Future<WeatherDetailsModel> getWeatherDetails({
    String location = "Kolkata",
  }) async {
    // Calls the repository method to fetch data from the data source (e.g., API).
    return await _repository.getWeather(location: location);
  }
}

