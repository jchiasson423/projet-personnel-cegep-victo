// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_maker_app/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:budget_maker_app/utilities/models/money_entry_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Widget pour afficher une ligne de budget
class BudgetLine extends StatefulWidget {
  /// Entrée
  final MoneyEntry entry;

  /// Largeur
  final double width;

  /// Couleur
  final Color color;

  /// Couleur du texte
  final Color textColor;

  /// Est-ce le budget courant
  final bool isCurrent;

  /// Est-ce qu'on est en mode édition
  final bool isEditing;

  /// Callback quand on change une entrée
  final MoneyEntry Function(MoneyEntry newEntry)? onChange;

  /// Callback quand on supprime une entrée
  final void Function(MoneyEntry entry)? onDelete;

  /// Constructeur
  const BudgetLine({
    super.key,
    required this.entry,
    required this.width,
    required this.color,
    required this.textColor,
    this.isCurrent = false,
    this.isEditing = false,
    this.onChange,
    this.onDelete,
  });

  @override
  State<BudgetLine> createState() => _BudgetLineState();
}

class _BudgetLineState extends State<BudgetLine> {
  /// Entrée
  late MoneyEntry entry;

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    entry = widget.entry;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.isEditing ? 125 : 35,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: widget.color,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: widget.isEditing
                    ? const EdgeInsets.only(top: 20)
                    : const EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Nom
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: !widget.isEditing
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  entry.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: widget.textColor,
                                      ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  initialValue: entry.name,
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .budget_line_name,
                                    hintText: AppLocalizations.of(context)!
                                        .budget_line_name,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    entry.name = value;
                                    if (widget.onChange != null) {
                                      widget.onChange!(entry);
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .budget_line_name_empty;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Montant
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          child: !widget.isEditing
                              ? Text(
                                  NumberFormat.simpleCurrency()
                                      .format(entry.amount),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: widget.textColor,
                                      ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 16),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue:
                                        entry.amount.toStringAsFixed(2),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,2}')),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .budget_foreseen_empty;
                                      }
                                      if (double.tryParse(value) == null) {
                                        return AppLocalizations.of(context)!
                                            .budget_foreseen_invalid;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!
                                          .budget_foreseen,
                                      hintText: AppLocalizations.of(context)!
                                          .budget_foreseen,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      suffixText: '\$',
                                    ),
                                    onChanged: (value) {
                                      entry.amount =
                                          double.tryParse(value) ?? 0;
                                      if (widget.onChange != null) {
                                        widget.onChange!(entry);
                                      }
                                    },
                                  ),
                                ),
                        ),

                        // Montant reçu affiché seulement si c'est le budget courant
                        if (widget.isCurrent)
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: !widget.isEditing
                                ? Text(
                                    NumberFormat.simpleCurrency()
                                        .format(entry.receivedAmount ?? 0),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: widget.textColor,
                                        ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      initialValue: (entry.receivedAmount ?? 0)
                                          .toStringAsFixed(2),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\.?\d{0,2}')),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return null;
                                        }
                                        if (double.tryParse(value) == null) {
                                          return AppLocalizations.of(context)!
                                              .budget_real_invalid;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!
                                            .budget_real,
                                        hintText: AppLocalizations.of(context)!
                                            .budget_real,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        suffixText: '\$',
                                      ),
                                      onChanged: (value) {
                                        entry.receivedAmount =
                                            double.tryParse(value);
                                        if (widget.onChange != null) {
                                          widget.onChange!(entry);
                                        }
                                      },
                                    ),
                                  ),
                          ),
                      ],
                    )
                  ],
                ),
              ),

              // Bouton de suppression affiché seulement si un callback est spécifié
              if (widget.onDelete != null)
                IconButton(
                  onPressed: () async {
                    var result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return ConfirmDialog(
                          message: AppLocalizations.of(context)!
                              .budget_line_delete_dialog,
                        );
                      },
                    );

                    if (result != true) {
                      return;
                    }

                    widget.onDelete!(widget.entry);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
