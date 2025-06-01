import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Core/Utils/log.dart';
import 'package:weatherapp/Screens/Home/Domain/Model/weather_details_model.dart';

// A Cubit for managing weather data
class WeatherSolutionsCubit extends Cubit<WeatherDetailsModel> {

  // Initial state must be set `WeatherDetailsModel.empty()` gives a safe default.
  WeatherSolutionsCubit() : super(WeatherDetailsModel.empty());

  // Updates the cubit state with new weather details
  // This method is called when weather data is successfully loaded
  // and I want to store structured weather details (e.g. sunrise, wind, humidity) separately.
  Future<void> setWeatherDetails(WeatherDetailsModel data) async {
    
    // Logs the encoded data for debugging purposes
    // Helps me inspect what's being emitted to the state
    AppLog().logMessage(message: "Data: ${json.encode(data)}");

    // Emits the new state
    // Updates the UI or any listener widgets with the latest data
    emit(data);
  }
}