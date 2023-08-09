// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_maker_app/utilities/entities/project_entity.dart';
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Dialogue pour créer une ligne de projet
/// Retourne l'entrée créée
class ProjectLineCreateDialog extends StatefulWidget {
  /// Entrées actuelles
  final List<ProjectEntry> currentEntries;

  /// Constructeur
  const ProjectLineCreateDialog({
    Key? key,
    required this.currentEntries,
  }) : super(key: key);

  @override
  State<ProjectLineCreateDialog> createState() =>
      _ProjectLineCreateDialogState();
}

class _ProjectLineCreateDialogState extends State<ProjectLineCreateDialog> {
  /// Clé du formulaire
  var formKey = GlobalKey<FormState>(debugLabel: 'project_line_form');

  /// Projet
  Project? project;

  List<Project>? projects;

  /// Sauvegarde l'entrée
  saveEntry() async {
    // Crée l'entrée
    var entry = ProjectEntry(
      projectId: project!.id!,
      amount: 0,
      project: project,
    );

    // Ferme le dialogue et retourne l'entrée
    Navigator.pop(context, entry);
  }

  Future<List<Project>> getProjects() async {
    projects ??= await Services.projects.getAll();
    return projects!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: FutureBuilder(
        future: getProjects(),
        builder: (context, snapshot) {
          // Affiche un indicateur de chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          // Affiche une erreur
          if (!snapshot.hasData || snapshot.hasError) {
            return const Text('Error');
          }

          var title = '';
          Widget content = Container();
          var showCreate = false;

          var projects = snapshot.data!;

          // Affiche un message si aucun projet n'est disponible
          if (projects.isEmpty) {
            title = AppLocalizations.of(context)!.project_entry_no_project;
          }

          var currentProjects = <Project>[];

          for (var project in projects) {
            if (widget.currentEntries
                .any((entry) => entry.projectId == project.id)) {
              continue;
            }
            currentProjects.add(project);
          }

          // Affiche un message si tous les projets ont une entrée
          if (currentProjects.isEmpty) {
            title = AppLocalizations.of(context)!.project_entry_all_set;
          }

          if (!projects.isEmpty && !currentProjects.isEmpty) {
            title = AppLocalizations.of(context)!.project_entry_add;
            showCreate = true;
            var projectDropdownItems = <DropdownMenuItem<Project>>[];

            // Ajoute les projets au menu déroulant
            for (var project in currentProjects) {
              projectDropdownItems.add(DropdownMenuItem<Project>(
                value: project,
                child: Text(project.name),
              ));
            }

            // Sélectionne le premier projet par défaut
            project ??= currentProjects.first;

            content = SizedBox(
              height: 300,
              child: DropdownButton<Project>(
                value: project,
                items: projectDropdownItems,
                onChanged: (value) {
                  setState(() {
                    project = value!;
                  });
                },
              ),
            );
          }

          return AlertDialog(
            // Titre du dialogue
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            // Sélection du projet
            content: content,
            actions: [
              // Bouton annuler
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.general_back),
              ),

              // Bouton sauvegarder
              if (showCreate)
                PrimaryButton(
                  onPressed: saveEntry,
                  text: AppLocalizations.of(context)!.general_save,
                ),
            ],
          );
        },
      ),
    );
  }
}
