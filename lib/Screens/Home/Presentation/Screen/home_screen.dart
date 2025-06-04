import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Common_Widgets/custom_mediaquery.dart';
import 'package:weatherapp/Screens/Home/Presentation/Bloc/weather_bloc.dart';
import 'package:weatherapp/Screens/Home/Presentation/Bloc/weather_event.dart';
import 'package:weatherapp/Screens/Home/Presentation/Bloc/weather_state.dart';
import 'package:weatherapp/Screens/Home/Presentation/Cubit/depot_solutions_cubit.dart';
import 'package:weatherapp/Screens/Home/Presentation/Screen/weather_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final TextEditingController searchController = TextEditingController();
  
  // Default location for initial API call
  String currentLocation = "Kolkata"; 

  @override
  void initState() {
    super.initState();
    // Initial API call for Kolkata
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherBloc>().add(FetchWeather(location: currentLocation));
    });
  }

  // Called when user submits a search query
  void _searchWeather(String location) {
    if (location.trim().isNotEmpty) {
      // I'm updating currentLocation, a local variable in my widget, not UI-related state.
      // It's purely for storing the last searched city for retry purposes.
      setState(() {
        currentLocation = location.trim();
      });
      context.read<WeatherBloc>().add(FetchWeather(location: location.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search input field
                SearchBar(
                  controller: searchController,
                  onSearch: _searchWeather,
                ),
                SizedBox(
                    height: CustomMediaquery()
                        .getHeight(height: 0.04, context: context),),
                Expanded(
                  // Rebuilds UI based on WeatherBloc state
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      // Loading State
                      if (state is WeatherLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } 
                      // Failed State
                      else if (state is WeatherError) {
                        // Showing error message and retry button
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: CustomMediaquery()
                                    .getHeight(height: 0.06, context: context),
                                color: Colors.red,
                              ),
                              SizedBox(
                                  height: CustomMediaquery().getHeight(
                                      height: 0.04, context: context)),
                              Text(
                                'Error',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                  height: CustomMediaquery().getHeight(
                                      height: 0.04, context: context)),
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: CustomMediaquery()
                                      .getWidth(width: 0.04, context: context),
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(
                                  height: CustomMediaquery().getHeight(
                                      height: 0.04, context: context)),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<WeatherBloc>().add(
                                        FetchWeather(location: currentLocation),
                                      );
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } 
                      // Loaded State
                      else if (state is WeatherLoaded) {
                        final weather = state.weatherData;
                        // Setting weather-related data (state) in cubit
                        BlocProvider.of<WeatherSolutionsCubit>(context).setWeatherDetails(weather);
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // City name with location icon
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                      height: CustomMediaquery().getHeight(
                                          height: 0.06, context: context)),
                                  Text(
                                    weather.location.name,
                                    style: TextStyle(
                                      fontSize: CustomMediaquery().getWidth(
                                          width: 0.06, context: context),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                              // Country and Region
                              Text(
                                "${weather.location.region}, ${weather.location.country}",
                                style: TextStyle(
                                  fontSize: CustomMediaquery().getWidth(
                                      width: 0.04, context: context),
                                  color: Colors.white70,
                                ),
                              ),

                              SizedBox(
                                  height: CustomMediaquery().getHeight(
                                      height: 0.006, context: context)),

                              // Main Weather Display
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Weather Icon and Description
                                    Column(
                                      children: [
                                        // Weather Image
                                        Image.network(
                                          weather.current.weatherIcons.first,
                                          width: CustomMediaquery().getWidth(
                                              width: 0.2, context: context),
                                          height: CustomMediaquery().getHeight(
                                              height: 0.2, context: context),
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(
                                              Icons.wb_cloudy,
                                              size: CustomMediaquery()
                                                  .getHeight(
                                                      height: 0.05,
                                                      context: context),
                                              color: Colors.white,
                                            );
                                          },
                                        ),
                                        SizedBox(
                                            height: CustomMediaquery()
                                                .getHeight(
                                                    height: 0.01,
                                                    context: context)),
                                        Text(
                                          weather.current.weatherDescriptions
                                                  .first
                                                  .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: CustomMediaquery()
                                                .getWidth(
                                                    width: 0.04,
                                                    context: context),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Temperature and Date
                                    Column(
                                      children: [
                                        Text(
                                          "Today",
                                          style: TextStyle(
                                            fontSize: CustomMediaquery()
                                                .getWidth(
                                                    width: 0.05,
                                                    context: context),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          weather.location.localtime,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        SizedBox(
                                            height: CustomMediaquery()
                                                .getHeight(
                                                    height: 0.04,
                                                    context: context)),
                                        Text(
                                          "${weather.current.temperature}°C",
                                          style: TextStyle(
                                            fontSize: CustomMediaquery()
                                                .getWidth(
                                                    width: 0.15,
                                                    context: context),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Feels like ${weather.current.feelslike}°C",
                                          style: TextStyle(
                                            fontSize: CustomMediaquery()
                                                .getWidth(
                                                    width: 0.04,
                                                    context: context),
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                  height: CustomMediaquery().getHeight(
                                      height: 0.04, context: context)),

                              // Weather Details Grid
                              WeatherDetailsGrid(),
                            ],
                          ),
                        );
                      }

                      // Initial state
                      return Center(
                        child: Text(
                          "Welcome to Weather App\nSearch for a city to get started",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: CustomMediaquery()
                                .getWidth(width: 0.04, context: context),
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      // ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Search for a city',
        prefixIcon: const Icon(Icons.search), // search icon on the left
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear), // clear icon to reset input
          onPressed: () {
            widget.controller.clear();
          },
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      onSubmitted: (value) {
        widget.onSearch(value); // triggers the _searchWeather method
      },
      textInputAction: TextInputAction.search,
    );
  }
}
