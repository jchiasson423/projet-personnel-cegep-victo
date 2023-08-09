import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/utilities/models/money_entry_model.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/budgets/budget_line_widget.dart';
import 'package:budget_maker_app/widgets/budgets/budget_lines_title_widget.dart';
import 'package:budget_maker_app/widgets/buttons/focus_button.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:budget_maker_app/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Widget pour afficher un budget dans une carte
class BudgetCard extends StatefulWidget {
  /// Budget
  final Budget budget;

  /// Solde du compte
  final double accountAmount;

  /// Fonction à appeler lors de la suppression du budget
  final void Function(Budget budget)? onDelete;

  /// Constructeur
  const BudgetCard(
      {super.key,
      required this.budget,
      required this.accountAmount,
      this.onDelete});

  @override
  State<BudgetCard> createState() => _BudgetCardState();
}

class _BudgetCardState extends State<BudgetCard> {
  /// Couleur de la carte
  Color get cardColor {
    if (widget.budget.isCurrent) {
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).colorScheme.surfaceVariant;
  }

  /// Couleur du texte
  Color get textColor {
    if (widget.budget.isCurrent) {
      return Theme.of(context).colorScheme.onPrimary;
    }
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }

  /// Style du titre
  TextStyle get titleStyle {
    return Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor);
  }

  /// Affiche les détails du budget
  void details() {
    context.beamToNamed('/dashboard/budget/${widget.budget.id}');
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
                          // Titre
                          Text(
                            '${DateFormat('yyyy-MM-dd').format(widget.budget.startDate)} - ${DateFormat('yyyy-MM-dd').format(widget.budget.endDate)}',
                            style: titleStyle,
                          ),
                          // Ligne de titre
                          BudgetLinesTitle(
                            width: constraints.maxWidth,
                            color: Colors.transparent,
                            textColor: textColor,
                            isCurrent: widget.budget.isCurrent ||
                                widget.budget.isPassed,
                          ),

                          // Ligne de revenus
                          BudgetLine(
                            entry: MoneyEntry(
                              name:
                                  AppLocalizations.of(context)!.budget_incomes,
                              amount: widget.budget.totalIncome,
                              receivedAmount: widget.budget.totalReceivedIncome,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.surface,
                            textColor: Theme.of(context).colorScheme.onSurface,
                            isCurrent: widget.budget.isCurrent ||
                                widget.budget.isPassed,
                            // isEditing: true,
                          ),
                          // Ligne de dépenses
                          BudgetLine(
                            entry: MoneyEntry(
                              name:
                                  AppLocalizations.of(context)!.budget_expenses,
                              amount: widget.budget.totalExpense,
                              receivedAmount:
                                  widget.budget.totalReceivedExpense,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.surface,
                            textColor: Theme.of(context).colorScheme.onSurface,
                            isCurrent: widget.budget.isCurrent ||
                                widget.budget.isPassed,
                          ),

                          // Ligne de projets
                          BudgetLine(
                            entry: MoneyEntry(
                              name:
                                  AppLocalizations.of(context)!.projects_title,
                              amount: widget.budget.totalProject,
                              receivedAmount:
                                  widget.budget.totalReceivedProject,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.surface,
                            textColor: Theme.of(context).colorScheme.onSurface,
                            isCurrent: widget.budget.isCurrent ||
                                widget.budget.isPassed,
                          ),

                          // Ligne de solde
                          BudgetLine(
                            entry: MoneyEntry(
                              name:
                                  AppLocalizations.of(context)!.budget_balance,
                              amount: widget.budget.total,
                              receivedAmount: widget.budget.totalReceived,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.secondary,
                            textColor:
                                Theme.of(context).colorScheme.onSecondary,
                            isCurrent: widget.budget.isCurrent ||
                                widget.budget.isPassed,
                          ),

                          // Ligne de solde du compte affiché si le budget n'est pas passé
                          if (!widget.budget.isPassed)
                            BudgetLine(
                              entry: MoneyEntry(
                                name: AppLocalizations.of(context)!
                                    .budget_account_amount,
                                amount:
                                    widget.accountAmount + widget.budget.total,
                                receivedAmount: widget.budget
                                    .realAccountAmout(widget.accountAmount),
                              ),
                              width: constraints.maxWidth,
                              color: !widget.budget.isCurrent
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onPrimary,
                              textColor: !widget.budget.isCurrent
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                              isCurrent: widget.budget.isCurrent ||
                                  widget.budget.isPassed,
                            ),
                        ],
                      ),

                      // Bouton de détails
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          widget.budget.isCurrent
                              ? FocusButton(
                                  text: AppLocalizations.of(context)!
                                      .general_details,
                                  onPressed: details)
                              : PrimaryButton(
                                  text: AppLocalizations.of(context)!
                                      .general_details,
                                  onPressed: details)
                        ],
                      ),
                    ],
                  ),
                ),

                // Bouton de suppression
                IconButton(
                  onPressed: () async {
                    var result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return ConfirmDialog(
                          message: AppLocalizations.of(context)!
                              .budget_delete_dialog,
                        );
                      },
                    );

                    if (result != true) {
                      return;
                    }
                    await Services.budgets.delete(widget.budget.id!);

                    if (widget.onDelete != null) {
                      widget.onDelete!(widget.budget);
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
