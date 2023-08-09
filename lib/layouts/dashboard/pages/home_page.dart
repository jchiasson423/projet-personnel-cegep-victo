import 'package:budget_maker_app/widgets/account/account_balance_widget.dart';
import 'package:budget_maker_app/utilities/services/events_service.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/budgets/budget_carousel_widget.dart';
import 'package:budget_maker_app/widgets/models/model_carousel_widget.dart';
import 'package:budget_maker_app/widgets/projects/project_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Page d'accueil de l'application
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Initialise l'état de la page
  @override
  void initState() {
    super.initState();
    // Rafraîchit la page quand l'utilisateur change le montant de son compte
    EventService.emitter.on('account/changed', context, refresh);
  }

  /// Libère les ressources utilisées par la page
  @override
  void dispose() {
    EventService.emitter.removeAllByCallback(refresh);
    super.dispose();
  }

  /// Rafraîchit la page
  refresh(_, __) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Va chercher le solde du compte
          FutureBuilder(
              future: Services.account.getBalance(),
              builder: (context, snapshot) {
                // Affiche chargement
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                // Affiche erreur
                if (!snapshot.hasData || snapshot.hasError) {
                  return const Text('Error');
                }

                return Column(
                  children: [
                    // Affiche le solde du compte
                    AccountBalance(balance: snapshot.data!),
                    // Affiche les modèles
                    ModelCarousel(future: Services.models.getAll),
                    // Affiche les budgets futurs
                    BudgetCarousel(
                      title: AppLocalizations.of(context)!.budget_future,
                      future: Services.budgets.getAfterEndDate,
                      accountAmount: snapshot.data!,
                      canAdd: true,
                    ),
                    // Affiche les projets
                    ProjectCarousel(
                      future: Services.projects.getAll,
                      onDelete: (project) {
                        setState(() {});
                      },
                    ),
                    // Affiche les budgets passés
                    BudgetCarousel(
                      title: AppLocalizations.of(context)!.budget_past,
                      future: Services.budgets.getBeforeEndDate,
                      accountAmount: snapshot.data!,
                      canAdd: false,
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
