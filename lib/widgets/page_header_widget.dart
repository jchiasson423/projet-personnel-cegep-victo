import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// En-tête de page
class PageHeader extends StatelessWidget {
  /// Titre
  final String title;

  /// Callback lors de l'enregistrement
  final void Function()? onSave;

  /// Constructeur
  const PageHeader({
    super.key,
    required this.title,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      // Bouton de retour
      IconButton(
        onPressed: () {
          context.beamToNamed('/dashboard/home');
        },
        icon: const Icon(Icons.arrow_back),
      ),

      // Titre de la page
      Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),

      // Bouton d'enregistrement
      onSave != null
          ? PrimaryButton(
              text: AppLocalizations.of(context)!.general_save,
              onPressed: onSave!,
            )
          : const SizedBox(
              width: 50,
            )
    ]);
  }
}
