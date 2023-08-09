import 'package:budget_maker_app/utilities/enums.dart';
import 'package:budget_maker_app/utilities/services/brigthness_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:animated_button_bar/animated_button_bar.dart';

/// Sélecteur du thème de l'application (clair, sombre, système)
class BrightnessSelector extends StatefulWidget {
  /// Constructeur
  const BrightnessSelector({
    super.key,
  });

  @override
  State<BrightnessSelector> createState() => _BrightnessSelectorState();
}

class _BrightnessSelectorState extends State<BrightnessSelector> {
  /// Contrôleur des boutons
  AnimatedButtonController controller = AnimatedButtonController();

  /// Sélection du thème
  BrightnessSelection brightness = BrightnessSelection.system;

  /// Initialise le widget
  @override
  void initState() {
    super.initState();
    brightness = BrightnessService.getCurrentSelection();
    controller.index = brightness.index;
  }

  @override
  Widget build(BuildContext context) {
    brightness = BrightnessService.getCurrentSelection();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Titre
                    Text(
                      AppLocalizations.of(context)!.brightness_section,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),

                // Boutons
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: AnimatedButtonBar(
                    controller: controller,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    radius: 8,
                    children: [
                      ButtonBarEntry(
                        onTap: () => BrightnessService.changeBrightness(
                            BrightnessSelection.system),
                        child: Text(
                          AppLocalizations.of(context)!.brightness_system,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                color: brightness == BrightnessSelection.system
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                      ButtonBarEntry(
                          onTap: () => BrightnessService.changeBrightness(
                              BrightnessSelection.light),
                          child: Text(
                            AppLocalizations.of(context)!.brightness_light,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: brightness == BrightnessSelection.light
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                          )),
                      ButtonBarEntry(
                          onTap: () => BrightnessService.changeBrightness(
                              BrightnessSelection.dark),
                          child: Text(
                            AppLocalizations.of(context)!.brightness_dark,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: brightness == BrightnessSelection.dark
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
