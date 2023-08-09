// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/utilities/entities/model_entity.dart';
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

/// Dialogue pour créer un budget
class BudgetCreateDialog extends StatefulWidget {
  const BudgetCreateDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<BudgetCreateDialog> createState() => _BudgetCreateDialogState();
}

class _BudgetCreateDialogState extends State<BudgetCreateDialog> {
  /// Clé pour le formulaire
  var formKey = GlobalKey<FormState>(debugLabel: 'budget_form');

  /// Modèle pour le budget
  Model? model;

  /// Date de début du budget
  DateTime startDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  /// Date de fin du budget
  DateTime endDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(const Duration(days: 14));

  /// Contrôleur pour la date de début
  TextEditingController startDateController = TextEditingController();

  /// Contrôleur pour la date de fin
  TextEditingController endDateController = TextEditingController();

  /// Initialise le dialogue
  @override
  void initState() {
    super.initState();
    startDateController.text = DateFormat('yyyy-MM-dd').format(startDate);
    endDateController.text = DateFormat('yyyy-MM-dd').format(endDate);
  }

  /// Ferme le dialogue
  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }

  /// Sauvegarde le budget
  saveBudget() async {
    // Valide le formulaire
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Récupère l'utilisateur
    var user = AuthService.getCurrentUser();

    Budget budget;

    // Si un modèle est sélectionné, crée le budget à partir du modèle
    // Sinon, crée un nouveau budget
    if (model != null) {
      budget = model!.createBudget(startDate, endDate);
    } else {
      budget = Budget(
        userId: user!.uid,
        startDate: startDate,
        endDate: endDate,
        incomes: [],
        expenses: [],
      );
    }

    // Crée le budget dans la base de données
    budget = await Services.budgets.create(budget);

    // Redirige vers le budget
    // ignore: use_build_context_synchronously
    context.beamToNamed('/dashboard/budget/${budget.id}');

    // Ferme le dialogue
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Titre
      title: Text(
        AppLocalizations.of(context)!.budget_add,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      // Formulaire
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sélection du modèle
            FutureBuilder(
              future: Services.models.getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.hasError) {
                  return const Text('Error');
                }

                var models = snapshot.data!;
                if (models.isEmpty) {
                  return Container();
                }

                var items = <DropdownMenuItem<Model?>>[
                  DropdownMenuItem(
                    value: null,
                    child: Text(AppLocalizations.of(context)!.general_none),
                  ),
                ];

                for (var model in models) {
                  items.add(
                    DropdownMenuItem(
                      value: model,
                      child: Text(model.name),
                    ),
                  );
                }

                return DropdownButton(
                    items: items,
                    value: model,
                    onChanged: (value) {
                      model = value;
                      setState(() {});
                    });
              },
            ),

            // Date de début
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                readOnly: true,
                controller: startDateController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.general_start_date,
                  hintText: AppLocalizations.of(context)!.general_start_date,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Valide que la date n'est pas vide
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!
                        .general_start_date_empty;
                  }
                  return null;
                },

                // Ouvre le calendrier pour sélectionner la date
                onTap: () async {
                  var newDate = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: DateTime(2000),
                    lastDate: endDate,
                  );
                  if (newDate == null) {
                    return;
                  }

                  startDate =
                      DateTime(newDate.year, newDate.month, newDate.day);
                  startDateController.text =
                      DateFormat('yyyy-MM-dd').format(startDate);
                  setState(() {});
                },
              ),
            ),

            // Date de fin
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                readOnly: true,
                controller: endDateController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.general_end_date,
                  hintText: AppLocalizations.of(context)!.general_end_date,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // Valide que la date n'est pas vide
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.general_end_date_empty;
                  }
                  return null;
                },

                // Ouvre le calendrier pour sélectionner la date
                onTap: () async {
                  var newDate = await showDatePicker(
                    context: context,
                    initialDate: endDate,
                    firstDate: startDate,
                    lastDate: DateTime(3000),
                  );
                  if (newDate == null) {
                    return;
                  }

                  endDate = DateTime(newDate.year, newDate.month, newDate.day);
                  endDateController.text =
                      DateFormat('yyyy-MM-dd').format(endDate);
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Bouton pour annuler
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(AppLocalizations.of(context)!.general_cancel)),
        // Bouton pour sauvegarder
        PrimaryButton(
          onPressed: saveBudget,
          text: AppLocalizations.of(context)!.general_save,
        ),
      ],
    );
  }
}
