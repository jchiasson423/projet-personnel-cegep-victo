import 'package:budget_maker_app/widgets/page_header_widget.dart';
import 'package:budget_maker_app/utilities/entities/project_entity.dart';
import 'package:budget_maker_app/utilities/guards/entity_guards/project_guard.dart';
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/projects/project_amount_form.dart';
import 'package:budget_maker_app/widgets/projects/project_date_form.dart';
import 'package:budget_maker_app/widgets/projects/project_line_widget.dart';
import 'package:budget_maker_app/widgets/projects/project_name_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

/// Page pour un projet
class ProjectPage extends StatefulWidget {
  const ProjectPage({
    super.key,
  });

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  /// Clé pour le formulaire
  var formKey = GlobalKey<FormState>(debugLabel: 'project_form');

  /// Entité du projet
  late Project entity;

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    entity = ProjectGuard.value;
  }

  /// Sauvegarde le projet
  saveProject() async {
    // Valide le formulaire
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Sauvegarde le projet
    entity = await Services.projects.update(entity.id!, entity);
    ProjectGuard.value = entity;

    // Affiche un message de succès
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          // ignore: use_build_context_synchronously
          AppLocalizations.of(context)!.general_save_success,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Formulaire pour le projet
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // En-tête de la page
            PageHeader(
              title: AppLocalizations.of(context)!.dashboard_project_title,
              onSave: saveProject,
            ),
            // Formulaire pour le nom du projet
            ProjectNameForm(
              name: entity.name,
              onChange: (newName) {
                entity.name = newName;
                setState(() {});
              },
            ),
            // Formulaire pour le montant actuel du projet
            ProjectAmountForm(
              amount: entity.currentAmount,
              title: AppLocalizations.of(context)!.project_current_amount,
              onChange: (newAmount) {
                entity.currentAmount = newAmount;
                setState(() {});
              },
              emptyString:
                  AppLocalizations.of(context)!.project_current_amount_empty,
              invalidString:
                  AppLocalizations.of(context)!.project_current_amount_invalid,
            ),
            // Formulaire pour le montant objectif du projet
            ProjectAmountForm(
              amount: entity.objective,
              title: AppLocalizations.of(context)!.project_objective,
              onChange: (newAmount) {
                entity.objective = newAmount;
                setState(() {});
              },
              emptyString:
                  AppLocalizations.of(context)!.project_objective_empty,
              invalidString:
                  AppLocalizations.of(context)!.project_objective_invalid,
            ),
            // Formulaire pour la date objectif du projet
            ProjectDateForm(
              date: entity.objectiveDate,
              onChange: (newDate) {
                entity.objectiveDate = newDate;
                setState(() {});
              },
            ),
            // Lignes pour le montant actuel du projetdu projet selon la date
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.project_entries_title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  // Création des lignes
                  Builder(builder: (context) {
                    var entries = entity.entries;
                    // Tri oar date
                    entries
                        .sort((a, b) => a.entryDate!.compareTo(b.entryDate!));

                    var amount = entity.currentAmount;
                    var items = <Widget>[];

                    // On ajoute à chaque ligne le montant de son entrée au montant précédent
                    // De cette manière on a le montant où on devrait être à cette date
                    for (var entry in entries) {
                      amount += entry.amount;
                      items.add(
                        ProjectLine(
                          entry: ProjectEntry(
                            amount: amount,
                            project: entity,
                            projectId: entity.id!,
                            entryDate: entry.entryDate,
                          ),
                          width: MediaQuery.of(context).size.width,
                          isCurrent: false,
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          textColor:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      );
                    }

                    return Column(
                      children: [
                        if (items.isEmpty)
                          Text(
                            AppLocalizations.of(context)!.project_entries_empty,
                          ),
                        ...items
                      ],
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
