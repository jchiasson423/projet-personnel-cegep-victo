import 'package:budget_maker_app/utilities/entities/model_entity.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Garde pour les modèles
class ModelGuard extends StatelessWidget {
  /// Enfant du garde à afficher
  final Widget child;

  /// Id du modèle
  final String id;

  /// Valeur du modèle chargé
  static late Model value;

  /// Constructeur
  const ModelGuard({
    super.key,
    required this.id,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Services.models.getById(id),
      builder: (context, snapshot) {
        // Si en attente, affiche un chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        // Si erreur ou pas de données, affiche un message d'erreur
        if (!snapshot.hasData || snapshot.hasError) {
          return Text(AppLocalizations.of(context)!.general_not_found);
        }

        // Charge le modèle
        ModelGuard.value = snapshot.data!;

        // Retourne l'enfant
        return child;
      },
    );
  }
}
