import 'package:equatable/equatable.dart';
import 'package:weatherapp/Screens/Home/Domain/Model/weather_details_model.dart';

// This is the base abstract class for all possible states of the weather feature.
// It extends Equatable to make state comparison efficient and value-based (not by reference).
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

// Initial state: used when the app just started or no action has been taken yet.
class WeatherInitial extends WeatherState {}

// Loading state: emitted while the weather data is being fetched from the API.
class WeatherLoading extends WeatherState {}

// Loaded state: emitted when weather data has been successfully fetched.
// Holds the actual weather data as a model.
class WeatherLoaded extends WeatherState {
  final WeatherDetailsModel weatherData;

  const WeatherLoaded(this.weatherData);

  // Ensures equality comparison includes weatherData.
  @override
  List<Object?> get props => [weatherData];
}

// Error state: emitted when something goes wrong while fetching data (e.g., network issues, 404).
// Holds an error message to show in the UI.
class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
