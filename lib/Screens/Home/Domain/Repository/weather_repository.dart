import 'package:weatherapp/Screens/Home/Domain/Model/weather_details_model.dart';

abstract class WeatherRepository {
  // Abstract method to fetch weather data for a given location.
  // The method returns a Future that completes with a WeatherDetailsModel.
  // If no location is provided, it defaults to "Kolkata".
  Future<WeatherDetailsModel> getWeather({String location});
}

