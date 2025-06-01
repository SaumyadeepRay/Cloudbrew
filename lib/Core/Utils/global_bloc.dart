import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Screens/Home/Presentation/Bloc/weather_bloc.dart';
import 'package:weatherapp/Screens/Home/Presentation/Cubit/depot_solutions_cubit.dart';
import '../di/injection_container.dart' as di;

// A widget that provides all global BLoC and Cubit instances to its widget subtree.

// This widget wraps around the app (or a large portion of the app) so
// that these BLoC/Cubit instances can be accessed anywhere below it in the widget tree.

// It uses [MultiBlocProvider] to provide multiple BLoC/Cubit instances at once,
// Improving code organization and avoiding repetitive provider setups.
class GlobalBloc extends StatelessWidget {
  final Widget child;

  // Constructor requires a [child] widget, which is the subtree that will have access
  // to the provided BLoCs/Cubits.
  const GlobalBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide the WeatherBloc instance using dependency injection (getIt).
        BlocProvider(create: (context) => di.getIt<WeatherBloc>()),

        // Provide the WeatherSolutionsCubit instance using dependency injection (getIt).
        BlocProvider(create: (context) => di.getIt<WeatherSolutionsCubit>()),
      ],

      // Pass down the child widget to give it access to the above providers.
      child: child,
    );
  }
}

