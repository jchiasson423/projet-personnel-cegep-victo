// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/utilities/entities/project_entity.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

/// Dialogue pour créer un projet
class ProjectCreateDialog extends StatefulWidget {
  const ProjectCreateDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectCreateDialog> createState() => _ProjectCreateDialogState();
}

class _ProjectCreateDialogState extends State<ProjectCreateDialog> {
  /// Clé du formulaire
  final formKey = GlobalKey<FormState>();

  /// Nom
  String name = '';

  /// Objectif
  double objective = 0;

  /// Date de l'objectif
  DateTime objectiveDate = DateTime.now().add(const Duration(days: 30));

  /// Contrôleur de la date de l'objectif
  TextEditingController objectiveDateController = TextEditingController();

  /// Initialise le widget
  @override
  void initState() {
    super.initState();
    objectiveDateController.text =
        DateFormat('yyyy-MM-dd').format(objectiveDate);
  }

  /// Détruit le widget
  @override
  void dispose() {
    super.dispose();
    objectiveDateController.dispose();
  }

  /// Sauvegarde le projet
  saveProject() async {
    // Vérifie que le formulaire est valide
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Crée le projet
    var project = await Services.projects.create(Project(
        name: name, objective: objective, objectiveDate: objectiveDate));

    // Redirige vers le projet
    // ignore: use_build_context_synchronously
    context.beamToNamed('/dashboard/project/${project.id}');

    // Ferme le dialogue
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Titre du dialogue
      title: Text(AppLocalizations.of(context)!.project_create,
          style: Theme.of(context).textTheme.titleLarge),

      // Formulaire
      content: Form(
        key: formKey,
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              // Nom
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.project_name,
                    hintText: AppLocalizations.of(context)!.project_name,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: name,

                  // Vérifie que le nom n'est pas vide
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.project_name_empty;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ),

              // Objectif
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: objective.toStringAsFixed(2),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],

                  // Vérifie que l'objectif est valide
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .project_objective_empty;
                    }
                    if (double.tryParse(value) == null) {
                      return AppLocalizations.of(context)!
                          .project_objective_invalid;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.project_objective,
                    hintText: AppLocalizations.of(context)!.project_objective,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixText: '\$',
                  ),
                  onChanged: (value) {
                    objective = double.tryParse(value) ?? 0;
                  },
                ),
              ),

              // Date de l'objectif
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: objectiveDateController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.general_end_date,
                    hintText: AppLocalizations.of(context)!.general_end_date,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // Vérifie que la date est valide
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .general_end_date_empty;
                    }
                    return null;
                  },

                  // Ouvre le sélecteur de date
                  onTap: () async {
                    var newDate = await showDatePicker(
                      context: context,
                      initialDate: objectiveDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(3000),
                    );
                    if (newDate == null) {
                      return;
                    }

                    objectiveDate =
                        DateTime(newDate.year, newDate.month, newDate.day);
                    objectiveDateController.text =
                        DateFormat('yyyy-MM-dd').format(objectiveDate);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Bouton annuler
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(AppLocalizations.of(context)!.general_cancel)),

        // Bouton sauvegarder
        PrimaryButton(
          onPressed: () {
            saveProject();
          },
          text: AppLocalizations.of(context)!.general_save,
        ),
      ],
    );
  }
}
