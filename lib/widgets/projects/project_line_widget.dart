// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:budget_maker_app/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Ligne d'un projet
class ProjectLine extends StatefulWidget {
  /// Titre
  final String? title;

  /// Entrée
  final ProjectEntry entry;

  /// Largeur
  final double width;

  /// Couleur
  final Color color;

  /// Couleur du texte
  final Color textColor;

  /// Est le budget courant
  final bool isCurrent;

  /// Est en édition
  final bool isEditing;

  /// Fonction à appeler lorsque l'entrée change
  final ProjectEntry Function(ProjectEntry newEntry)? onChange;

  /// Fonction à appeler lorsque l'entrée est supprimée
  final void Function(ProjectEntry entry)? onDelete;

  /// Constructeur
  const ProjectLine({
    super.key,
    required this.entry,
    required this.width,
    required this.color,
    required this.textColor,
    this.isCurrent = false,
    this.isEditing = false,
    this.onChange,
    this.onDelete,
    this.title,
  });

  @override
  State<ProjectLine> createState() => _ProjectLineState();
}

class _ProjectLineState extends State<ProjectLine> {
  /// Entrée
  late ProjectEntry entry;

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
                  children: [
                    // Titre
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.title != null
                                  ? widget.title!
                                  : widget.isEditing
                                      ? entry.project!.name
                                      : DateFormat('yyyy-MM-dd')
                                          .format(entry.entryDate!),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: widget.textColor,
                                  ),
                            ),
                          )),
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

                        // Montant réel affiché seulement si c'est le budget courant
                        if (widget.isCurrent)
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: !widget.isEditing
                                ? Text(
                                    NumberFormat.simpleCurrency()
                                        .format(entry.realAmount ?? 0),
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
                                      initialValue: (entry.realAmount ?? 0)
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
                                        entry.realAmount =
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

              // Bouton de suppression affiché seulement si une fonction est passée
              if (widget.onDelete != null)
                IconButton(
                  onPressed: () async {
                    var result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return ConfirmDialog(
                          message: AppLocalizations.of(context)!
                              .project_entry_delete_dialog,
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
