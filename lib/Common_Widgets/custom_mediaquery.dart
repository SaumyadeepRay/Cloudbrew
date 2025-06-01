import 'package:flutter/material.dart';

class CustomMediaquery {

  // Returns a width value as a fraction of the device screen width
  double getWidth({required width, required BuildContext context}) {
    return MediaQuery.of(context).size.width * width;
  }

  // Returns a height value as a fraction of the device screen height
  double getHeight({required double height, required BuildContext context}) {
    return MediaQuery.of(context).size.height * height;
  }
}
