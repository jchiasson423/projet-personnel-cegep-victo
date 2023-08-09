import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Garde pour les budgets
/// Vérifie si le budget existe et le charge
class BudgetGuard extends StatelessWidget {
  /// Enfant du garde à afficher
  final Widget child;

  /// Id du budget
  final String id;

  /// Valeur du budget chargé
  static late Budget value;

  /// Constructeur
  const BudgetGuard({
    super.key,
    required this.id,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Services.budgets.getById(id),
      builder: (context, snapshot) {
        // Si en attente, affiche un chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        // Si erreur ou pas de données, affiche un message d'erreur
        if (!snapshot.hasData || snapshot.hasError) {
          return Text(AppLocalizations.of(context)!.general_not_found);
        }

        // Charge le budget
        BudgetGuard.value = snapshot.data!;

        // Retourne l'enfant
        return child;
      },
    );
  }
}
