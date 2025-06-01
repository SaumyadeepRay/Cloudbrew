import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Common_Widgets/custom_mediaquery.dart';
import 'package:weatherapp/Screens/Home/Presentation/Cubit/depot_solutions_cubit.dart';

class WeatherDetailsGrid extends StatefulWidget {

  const WeatherDetailsGrid({super.key});

  @override
  State<WeatherDetailsGrid> createState() => _WeatherDetailsGridState();
}

// Widget that displays a grid of detailed weather metrics like humidity,
// wind speed, sunrise/sunset, etc.
class _WeatherDetailsGridState extends State<WeatherDetailsGrid> {
  @override
  Widget build(BuildContext context) {

    // Access the current weather data from the WeatherSolutionsCubit
    final current = BlocProvider.of<WeatherSolutionsCubit>(context).state;

    return GridView.count(
      shrinkWrap: true, // Allow GridView to take only needed space
      crossAxisCount: 3, // Display 3 items per row
      crossAxisSpacing: CustomMediaquery().getWidth(width: 0.02, context: context), // Horizontal spacing between grid items
      mainAxisSpacing: CustomMediaquery().getHeight(height: 0.02, context: context), // Vertical spacing between grid items
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
      children: [
        WeatherDetailItem("${current.current.humidity}%", "Humidity", Icons.water_drop),
        WeatherDetailItem("${current.current.windSpeed} km/h", "Wind Speed", Icons.air),
        WeatherDetailItem(current.current.weatherDescriptions.first,"Conditions", Icons.cloud),
        WeatherDetailItem(current.current.astro.sunrise, "Sunrise", Icons.wb_twighlight),
        WeatherDetailItem(current.current.astro.sunset, "Sunset", Icons.wb_sunny),
        WeatherDetailItem("${current.current.pressure} hPa", "Pressure", Icons.speed),
        WeatherDetailItem("${current.current.visibility} km", "Visibility", Icons.visibility),
        WeatherDetailItem("${current.current.uvIndex}", "UV Index", Icons.wb_sunny_outlined),
        WeatherDetailItem("${current.current.cloudcover}%", "Cloud Cover",Icons.cloud_outlined),
      ],
    );
  }
}

// Widget to display a single weather detail item with icon, value, and label.
class WeatherDetailItem extends StatefulWidget {
  final String value;
  final String label;
  final IconData icon;

  const WeatherDetailItem(this.value, this.label, this.icon, {super.key});

  @override
  State<WeatherDetailItem> createState() => _WeatherDetailItemState();
}

class _WeatherDetailItemState extends State<WeatherDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: CustomMediaquery().getWidth(width: 0.02, context: context),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, size: 28, color: Colors.white),
          SizedBox(
            height:
                CustomMediaquery().getHeight(height: 0.01, context: context),
          ),
          Flexible(
            child: Text(
              widget.value,
              style: TextStyle(
                color: Colors.white,
                fontSize:
                    CustomMediaquery().getWidth(width: 0.04, context: context),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              widget.label,
              style: TextStyle(
                color: Colors.white70,
                fontSize:
                    CustomMediaquery().getWidth(width: 0.03, context: context),
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
