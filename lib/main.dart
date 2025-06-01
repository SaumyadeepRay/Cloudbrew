import 'package:flutter/material.dart';
import 'package:weatherapp/Core/DI/injection_container.dart' as di;
import 'package:weatherapp/Core/Utils/global_bloc.dart';
import 'package:weatherapp/Screens/Splash/Presentation/Screen/splash_screen.dart';

void main() async {
  // Ensures that widget binding is initialized before executing any async operations
  // especially useful when using platform channels or initializing plugins before runApp.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setup dependency injection (e.g., registering services, blocs, or repositories)
  // This prepares the app to access shared dependencies throughout the widget tree.
  di.setupDependencies();
  
  // Entry point of the Flutter application, launches the UI.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalBloc(
      // GlobalBloc wraps the entire app to provide global state management
      // (like BlocProvider, Provider, etc.) to the widget tree.
      child: MaterialApp(
        title: 'Weather App',

        // Hides the debug banner in the top-right corner
        debugShowCheckedModeBanner: false,

        // Sets the initial screen to SplashScreen, shown when app launches
        home: const SplashScreen(),
      ),
    );
  }
}

