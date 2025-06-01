import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Common_Widgets/custom_mediaquery.dart';
import 'package:weatherapp/Screens/Home/Presentation/Bloc/weather_bloc.dart';
import 'package:weatherapp/Screens/Home/Presentation/Bloc/weather_state.dart';
import 'package:weatherapp/Screens/Home/Presentation/Screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Used here to simulate a splash screen delay of 4 seconds.
    Future.delayed(const Duration(seconds: 4), () {
      // After the delay, navigate to the HomeScreen.
      // pushReplacement is used so that the splash screen is removed from the stack.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BlocConsumer listens to changes in WeatherBloc and rebuilds UI accordingly.
      body: BlocConsumer<WeatherBloc, WeatherState>(
        // Listener handles side-effects like showing a Snackbar or navigation.
        listener: (context, state) {},

        // Builder rebuilds UI based on the current WeatherState.
        builder: (context, state) {

          //Loading State
          if (state is WeatherLoading) {
            // Show a loading spinner if weather data is being fetched.
            return Center(child: CircularProgressIndicator());
          } 
          
          // Failed State
          else if (state is WeatherError) {
            // Show an error message if fetching weather data fails.
            return Center(child: Text(state.message));
          }

          // Loaded State
          return SafeArea(
            child: Stack(
              children: [
                // Fullscreen background image for the splash screen.
                Image.asset(
                  'assets/images/splash_screen.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Overlayed text centered on the screen.
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Weather Matters, We've Got The Details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // Custom font size based on screen width using CustomMediaquery helper.
                        fontSize: CustomMediaquery()
                            .getWidth(width: 0.09, context: context),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

