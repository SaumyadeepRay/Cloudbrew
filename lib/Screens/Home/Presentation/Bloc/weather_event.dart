import 'package:equatable/equatable.dart';

// This is the base abstract class for all weather-related events.
// It extends Equatable to support value comparison (useful for BLoC event equality checks).
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  // This is required by Equatable to compare event instances properly.
  @override
  List<Object?> get props => [];
}

// This is a specific event class for fetching weather data.
// It will be triggered by the UI (like when a user searches for a city).
class FetchWeather extends WeatherEvent {
  final String? location;

  // Constructor for the event. The location is optional (nullable).
  // I pass the city name here when calling this event.
  const FetchWeather({this.location});

  // Used by Equatable to compare event instances.
  // This ensures BLoC doesn't unnecessarily rebuild if the same event is fired again.
  @override
  List<Object?> get props => [location];
}

