// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:budget_maker_app/widgets/budgets/budget_line_widget.dart';
import 'package:flutter/material.dart';

import 'package:budget_maker_app/utilities/models/money_entry_model.dart';

/// Éditeur de lignes de budget
class BudgetLinesEditor extends StatefulWidget {
  /// Liste des entrées
  final List<MoneyEntry> entries;

  /// Titre
  final String title;

  /// Peut ajouter
  final bool canAdd;

  /// Peut supprimer
  final bool canDelete;

  /// Est courant
  final bool isCurrent;

  /// Callback de changement
  final void Function(List<MoneyEntry> entries)? onChange;

  /// Constructeur
  const BudgetLinesEditor({
    super.key,
    required this.entries,
    required this.title,
    this.canAdd = true,
    this.canDelete = true,
    this.isCurrent = false,
    this.onChange,
  });

  @override
  State<BudgetLinesEditor> createState() => _BudgetLinesEditorState();
}

class _BudgetLinesEditorState extends State<BudgetLinesEditor> {
  /// Entrées
  late List<MoneyEntry> entries;

  /// Initialise le widget
  @override
  void initState() {
    super.initState();
    entries = widget.entries;
  }

  @override
  Widget build(BuildContext context) {
    // Trie les entrées
    entries.sort((a, b) => a.name.compareTo(b.name));
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Titre
              Text(widget.title,
                  style: Theme.of(context).textTheme.headlineMedium),

              // Bouton pour ajouter une entrée affiché si on peut ajouter
              if (widget.canAdd)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    entries.add(MoneyEntry(name: '', amount: 0));
                    if (widget.onChange != null) {
                      widget.onChange!(widget.entries);
                    }
                    setState(() {});
                  },
                ),
            ],
          ),

          // Liste des entrées
          for (var i = 0; i < entries.length; i++)
            BudgetLine(
              key: Key(
                  '${entries[i].hashCode}_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000000)}}'),
              entry: entries[i],
              isCurrent: widget.isCurrent,
              isEditing: true,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.surfaceVariant,
              textColor: Theme.of(context).colorScheme.onSurfaceVariant,
              onChange: (newEntry) {
                entries[i] = newEntry;
                if (widget.onChange != null) {
                  widget.onChange!(widget.entries);
                }

                return entries[i];
              },
              onDelete: !widget.canDelete
                  ? null
                  : (entry) {
                      entries.remove(entry);
                      if (widget.onChange != null) {
                        widget.onChange!(widget.entries);
                      }
                      setState(() {});
                    },
            ),
        ],
      ),
    );
  }
}
