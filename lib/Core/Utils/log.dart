import 'dart:developer';
import 'package:flutter/foundation.dart';

// A simple logging utility class used for debugging purposes.
class AppLog {
  void logMessage({required dynamic message}) {
    if (kDebugMode) {
      log(message);
    }
  }
}
