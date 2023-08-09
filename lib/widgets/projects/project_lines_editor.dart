// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:budget_maker_app/widgets/dialogs/project_line_create_dialog.dart';
import 'package:budget_maker_app/widgets/projects/project_line_widget.dart';
import 'package:flutter/material.dart';

/// Éditeur de lignes de projet
class ProjectLinesEditor extends StatefulWidget {
  /// Liste des entrées
  final List<ProjectEntry> entries;

  /// Titre
  final String title;

  /// Peut ajouter
  final bool canAdd;

  /// Peut supprimer
  final bool canDelete;

  /// Est courant
  final bool isCurrent;

  /// Fonction à appeler lorsque la liste change
  final void Function(List<ProjectEntry> entries)? onChange;

  /// Constructeur
  const ProjectLinesEditor({
    super.key,
    required this.entries,
    required this.title,
    this.canAdd = true,
    this.canDelete = true,
    this.isCurrent = false,
    this.onChange,
  });

  @override
  State<ProjectLinesEditor> createState() => _ProjectLinesEditorState();
}

class _ProjectLinesEditorState extends State<ProjectLinesEditor> {
  /// Liste des entrées
  late List<ProjectEntry> entries;

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    entries = widget.entries;
  }

  @override
  Widget build(BuildContext context) {
    // Trie les entrées par nom de projet
    entries.sort((a, b) => a.project!.name.compareTo(b.project!.name));

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

              // Bouton pour ajouter une ligne
              if (widget.canAdd)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    // Affiche la boîte de dialogue pour créer une entrée
                    var result = await showDialog(
                        context: context,
                        builder: (context) {
                          return ProjectLineCreateDialog(
                            currentEntries: entries,
                          );
                        });

                    // Si l'utilisateur a annulé, ne fait rien
                    if (result == null) {
                      return;
                    }

                    // Ajoute l'entrée
                    entries.add(result);
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
            ProjectLine(
              key: Key(
                  '${entries[i].hashCode}_${DateTime.now().millisecondsSinceEpoch}'),
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
