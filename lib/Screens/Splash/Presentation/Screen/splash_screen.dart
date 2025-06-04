import 'package:flutter/material.dart';
import 'package:weatherapp/Common_Widgets/custom_mediaquery.dart';
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
      body: SafeArea(
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
      ),
    );
  }
}
