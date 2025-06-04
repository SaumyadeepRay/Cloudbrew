import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Core/Utils/log.dart';
import 'package:weatherapp/Screens/Home/Domain/UseCase/weather_usecase.dart';
import 'package:weatherapp/Screens/Home/Presentation/Bloc/weather_event.dart';
import 'package:weatherapp/Screens/Home/Presentation/Bloc/weather_state.dart';

// Bloc that handles weather-related events and manages state transitions.
// Separates business logic (API calls, data handling) from UI, making the app scalable and testable.
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecase _usecase; // Dependency-injected use case that abstracts weather fetching logic
  String? _currentLocation; // Stores the last searched location for retry functionality

  // Constructor initializes the BLoC and listens for `FetchWeather` events
  WeatherBloc(this._usecase) : super(WeatherInitial()) {
    // Event handler for FetchWeather
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading()); // Emit loading state to show spinner in UI

      try {
        // Use location from event to the last used location
        String location = event.location ?? _currentLocation!;
        _currentLocation = location; // Save current location for retry

        // Call the use case to fetch weather details
        final weatherDetails =
            await _usecase.getWeatherDetails(location: location);

        // Log the result for debugging
        AppLog()
            .logMessage(message: "Weather Data: ${jsonEncode(weatherDetails)}");

        // Emit the loaded state with fetched data
        emit(WeatherLoaded(weatherDetails));
      } catch (e, stackTrace) {
        // Log error and stack trace for debugging
        AppLog().logMessage(message: "Error: ${e.toString()}");
        AppLog().logMessage(message: "Stacktrace: $stackTrace");

        // User-friendly error message
        String errorMessage = 'City not found. Please check the spelling and try again.';
        if (e.toString().contains('404') || e.toString().contains('network') ||
            e.toString().contains('connection')) {
          errorMessage =
              'Network error. Please check your internet connection.';
        }

        // Emit error state
        emit(WeatherError(errorMessage));
      }
    });
  }

  // Getter to expose the last searched location
  // Useful for UI to retry the last query or display the current location name
  String get currentLocation => _currentLocation!;
}
