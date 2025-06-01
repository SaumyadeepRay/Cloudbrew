import 'package:get_it/get_it.dart';
import 'package:weatherapp/Core/Network/api_service.dart';
import 'package:weatherapp/Screens/Home/Data/DataSource/weather_remote_data_source.dart';
import 'package:weatherapp/Screens/Home/Data/Repository/weather_repository_impl.dart';
import 'package:weatherapp/Screens/Home/Domain/Repository/weather_repository.dart';
import 'package:weatherapp/Screens/Home/Domain/UseCase/weather_usecase.dart';
import 'package:weatherapp/Screens/Home/Presentation/Bloc/weather_bloc.dart';
import 'package:weatherapp/Screens/Home/Presentation/Cubit/depot_solutions_cubit.dart';

// Gets me the global singleton instance of GetIt, 
// allowing my app to manage and retrieve dependencies in a centralized, consistent, and easy way.
final GetIt getIt = GetIt.instance;

// Sets up and registers all dependencies used in the app.
// This enables easy access and management of objects through dependency injection.
void setupDependencies() {
  // Register APIService as a lazy singleton:
  // - Only one instance will be created and shared throughout the app.
  // - Lazily initialized when first requested.
  getIt.registerLazySingleton<APIService>(() => APIService());

  // Register WeatherSolutionsCubit as a lazy singleton:
  // - Provides weather-related state management.
  // - Single instance shared across the app.
  getIt.registerLazySingleton<WeatherSolutionsCubit>(() => WeatherSolutionsCubit());

  // Register WeatherRemoteDataSource implementation as a lazy singleton:
  // - Depends on APIService, injected automatically by getIt().
  // - Responsible for fetching weather data from remote API.
  getIt.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(getIt()));

  // Register WeatherRepository implementation as a lazy singleton:
  // - Depends on WeatherRemoteDataSource.
  // - Acts as an abstraction layer between data sources and business logic.
  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(getIt()));

  // Register WeatherUsecase as a lazy singleton:
  // - Depends on WeatherRepository.
  // - Encapsulates business logic to get weather data.
  getIt.registerLazySingleton<WeatherUsecase>(() => WeatherUsecase(getIt()));

  // Register WeatherBloc with a factory:
  // - Provides weather-related event handling and state management.
  // - Factory creates a new instance every time it's requested.
  // - Depends on WeatherUsecase.
  getIt.registerFactory<WeatherBloc>(() => WeatherBloc(getIt()));
}

