import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/utilities/entities/model_entity.dart';
import 'package:budget_maker_app/utilities/models/money_entry_model.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/budgets/budget_line_widget.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:budget_maker_app/widgets/dialogs/confirm_dialog.dart';
import 'package:budget_maker_app/widgets/models/model_lines_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Carte d'un modèle
class ModelCard extends StatefulWidget {
  /// Modèle
  final Model model;

  /// Callback lors de la suppression
  final void Function(Model model)? onDelete;

  /// Constructeur
  const ModelCard({super.key, required this.model, this.onDelete});

  @override
  State<ModelCard> createState() => _ModelCardState();
}

class _ModelCardState extends State<ModelCard> {
  // Couleur de la carte
  Color get cardColor {
    return Theme.of(context).colorScheme.surfaceVariant;
  }

  // Couleur du texte
  Color get textColor {
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }

  // Style du titre
  TextStyle get titleStyle {
    return Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor);
  }

  /// Affiche les détails
  void details() {
    context.beamToNamed('/dashboard/model/${widget.model.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        // height: 600,
        child: LayoutBuilder(builder: (context, constraints) {
          return Card(
            color: cardColor,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          // Nom
                          Text(
                            widget.model.name,
                            style: titleStyle,
                          ),

                          // Titre des lignes
                          ModelLinesTitle(
                            width: constraints.maxWidth,
                            color: Colors.transparent,
                            textColor: textColor,
                          ),

                          // Ligne des revenus
                          BudgetLine(
                            entry: MoneyEntry(
                              name:
                                  AppLocalizations.of(context)!.budget_incomes,
                              amount: widget.model.totalIncome,
                              receivedAmount: 0,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.surface,
                            textColor: Theme.of(context).colorScheme.onSurface,
                            isCurrent: false,
                            // isEditing: true,
                          ),

                          // Ligne des dépenses
                          BudgetLine(
                            entry: MoneyEntry(
                              name:
                                  AppLocalizations.of(context)!.budget_expenses,
                              amount: widget.model.totalExpense,
                              receivedAmount: 0,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.surface,
                            textColor: Theme.of(context).colorScheme.onSurface,
                            isCurrent: false,
                          ),

                          // Ligne des projets
                          BudgetLine(
                            entry: MoneyEntry(
                              name:
                                  AppLocalizations.of(context)!.projects_title,
                              amount: widget.model.totalProject,
                              receivedAmount: 0,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.surface,
                            textColor: Theme.of(context).colorScheme.onSurface,
                            isCurrent: false,
                          ),

                          // Ligne du solde
                          BudgetLine(
                            entry: MoneyEntry(
                              name:
                                  AppLocalizations.of(context)!.budget_balance,
                              amount: widget.model.total,
                              receivedAmount: 0,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.secondary,
                            textColor:
                                Theme.of(context).colorScheme.onSecondary,
                            isCurrent: false,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Bouton pour voir les détails
                          PrimaryButton(
                              text:
                                  AppLocalizations.of(context)!.general_details,
                              onPressed: details)
                        ],
                      ),
                    ],
                  ),
                ),

                // Bouton pour supprimer
                IconButton(
                  onPressed: () async {
                    var result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return ConfirmDialog(
                          message:
                              AppLocalizations.of(context)!.model_delete_dialog,
                        );
                      },
                    );

                    if (result != true) {
                      return;
                    }
                    await Services.models.delete(widget.model.id!);

                    if (widget.onDelete != null) {
                      widget.onDelete!(widget.model);
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
