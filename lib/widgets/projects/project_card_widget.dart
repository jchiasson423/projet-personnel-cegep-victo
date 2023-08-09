import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/utilities/entities/project_entity.dart';
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/buttons/focus_button.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:budget_maker_app/widgets/dialogs/confirm_dialog.dart';
import 'package:budget_maker_app/widgets/projects/project_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

/// Carte d'un projet
class ProjectCard extends StatefulWidget {
  /// Projet à afficher
  final Project project;

  /// Callback lors de la suppression
  final void Function(Project project)? onDelete;

  /// Constructeur
  const ProjectCard({super.key, required this.project, this.onDelete});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  /// Couleur de la carte
  Color get cardColor {
    return widget.project.accomplished
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surfaceVariant;
  }

  /// Couleur du texte
  Color get textColor {
    return widget.project.accomplished
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSurfaceVariant;
  }

  /// Style du titre
  TextStyle get titleStyle {
    return Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor);
  }

  /// Affiche les détails
  void details() {
    context.beamToNamed('/dashboard/project/${widget.project.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
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
                          // Nom du projet
                          Text(
                            widget.project.name,
                            style: titleStyle,
                          ),

                          // Ligne du montant actuel
                          ProjectLine(
                            entry: ProjectEntry(
                              amount: widget.project.currentAmount,
                              projectId: widget.project.id!,
                              project: widget.project,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.secondary,
                            textColor:
                                Theme.of(context).colorScheme.onSecondary,
                            isCurrent: false,
                            title: AppLocalizations.of(context)!
                                .project_current_amount,
                            // isEditing: true,
                          ),

                          // Ligne de l'objectif
                          ProjectLine(
                            entry: ProjectEntry(
                              amount: widget.project.objective,
                              projectId: widget.project.id!,
                              project: widget.project,
                            ),
                            width: constraints.maxWidth,
                            color: Theme.of(context).colorScheme.surface,
                            textColor: Theme.of(context).colorScheme.onSurface,
                            isCurrent: false,
                            title:
                                '${AppLocalizations.of(context)!.project_objective} - ${DateFormat('yyyy-MM-dd').format(widget.project.objectiveDate)}',
                            // isEditing: true,
                          ),

                          // Ligne du montant à la date de l'objectif
                          ProjectLine(
                            entry: ProjectEntry(
                              amount: widget.project.amountAtDate,
                              projectId: widget.project.id!,
                              project: widget.project,
                            ),
                            width: constraints.maxWidth,
                            color: widget.project.accomplishedAtDate
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.secondary,
                            textColor: widget.project.accomplishedAtDate
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSecondary,
                            isCurrent: false,
                            title: AppLocalizations.of(context)!
                                .project_amount_at_date,
                          ),
                        ],
                      ),

                      // Bouton pour afficher les détails
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          widget.project.accomplished
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

                // Bouton pour supprimer le projet
                IconButton(
                  onPressed: () async {
                    var result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return ConfirmDialog(
                          message: AppLocalizations.of(context)!
                              .project_delete_dialog,
                        );
                      },
                    );

                    if (result != true) {
                      return;
                    }
                    await Services.projects.delete(widget.project.id!);

                    if (widget.onDelete != null) {
                      widget.onDelete!(widget.project);
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
