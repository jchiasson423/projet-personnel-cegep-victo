import 'package:budget_maker_app/utilities/enums.dart';
import 'package:budget_maker_app/utilities/services/events_service.dart';
import 'package:budget_maker_app/utilities/services/local_storage.dart';
import 'package:flutter/material.dart';

/// Service pour gérer le thème (clair, sombre, système)
class BrightnessService {
  /// Retourne le thème courant
  static Brightness getCurrentBrightness(BuildContext context) {
    // Récupère la valeur de la sélection dans le stockage local
    var brightnessValue = getCurrentSelection();

    // Retourne le thème correspondant à la valeur
    switch (brightnessValue) {
      case BrightnessSelection.light:
        return Brightness.light;
      case BrightnessSelection.dark:
        return Brightness.dark;
      case BrightnessSelection.system:
      default:
        return MediaQuery.platformBrightnessOf(context);
    }
  }

  /// Retourne la sélection courante à partir du stockage local
  static BrightnessSelection getCurrentSelection() {
    return BrightnessSelection.values[int.parse(
      LocalStorage.get('brightness') ??
          BrightnessSelection.system.index.toString(),
    )];
  }

  /// Change le thème courant
  static void changeBrightness(BrightnessSelection selection) {
    LocalStorage.set('brightness', selection.index.toString());
    EventService.emitter.emit('brightness/changed', null, selection);
  }
}
