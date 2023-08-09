import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/widgets/base_carousel_widget.dart';
import 'package:budget_maker_app/widgets/budgets/budget_card_widget.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:budget_maker_app/widgets/dialogs/budget_create_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Widget pour afficher les budgets dans un carousel
class BudgetCarousel extends StatefulWidget {
  /// Titre
  final String title;

  /// Future pour récupérer les budgets
  final Future<List<Budget>> Function() future;

  /// Solde du compte
  final double accountAmount;

  /// Peut-on ajouter un budget
  final bool canAdd;

  /// Constructeur
  const BudgetCarousel({
    super.key,
    required this.title,
    required this.future,
    required this.accountAmount,
    this.canAdd = false,
  });

  @override
  State<BudgetCarousel> createState() => _BudgetCarouselState();
}

class _BudgetCarouselState extends State<BudgetCarousel> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Budget>>(
      future: widget.future(),
      builder: (context, snapshot) {
        // Si on est en attente, affiche un chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        // Si on a une erreur, affiche un message d'erreur
        if (!snapshot.hasData || snapshot.hasError) {
          return const SizedBox(
            height: 350,
            child: Text('Error'),
          );
        }

        var budgets = snapshot.data!;
        double accountAmout = widget.accountAmount;
        List<Widget> items = [];

        // Ajoute les widgets des budgets
        for (var budget in budgets) {
          items.add(
            BudgetCard(
              budget: budget,
              accountAmount: accountAmout,
              onDelete: (budget) {
                setState(() {});
              },
            ),
          );

          // Calcule le solde du compte selon le budget d'avant
          var totalReceived = budget.totalReceived;
          if (totalReceived != 0) {
            accountAmout += totalReceived;
            continue;
          }
          accountAmout += budget.total;
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Titre
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  // Bouton pour ajouter un budget
                  if (widget.canAdd)
                    PrimaryButton(
                      text: AppLocalizations.of(context)!.budget_add,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const BudgetCreateDialog(),
                        );
                      },
                    ),
                ],
              ),

              // Carousel
              BaseCarousel(
                noResultMessage: AppLocalizations.of(context)!.budget_no_result,
                items: items,
              ),
            ],
          ),
        );
      },
    );
  }
}
