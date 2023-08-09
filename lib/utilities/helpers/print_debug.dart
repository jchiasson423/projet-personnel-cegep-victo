import 'package:flutter/foundation.dart';

/// Affiche un message de débogage si en mode débogage
printDebug(String message) {
  if (kDebugMode) {
    print(message);
  }
}
