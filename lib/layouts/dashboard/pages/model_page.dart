import 'package:budget_maker_app/utilities/services/events_service.dart';
import 'package:budget_maker_app/widgets/page_header_widget.dart';
import 'package:budget_maker_app/utilities/entities/model_entity.dart';
import 'package:budget_maker_app/utilities/guards/entity_guards/model_guard.dart';
import 'package:budget_maker_app/widgets/models/model_name_form.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/budgets/balance_widget.dart';
import 'package:budget_maker_app/widgets/budgets/budget_lines_editor.dart';
import 'package:budget_maker_app/widgets/projects/project_lines_editor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Page pour un modèle de budget
class ModelPage extends StatefulWidget {
  const ModelPage({
    super.key,
  });

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  /// Clé pour le formulaire
  var formKey = GlobalKey<FormState>(debugLabel: 'model_form');

  /// Entité du modèle
  late Model entity;

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    entity = ModelGuard.value;
  }

  /// Sauvegarde le modèle
  saveModel() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    entity = await Services.models.update(entity.id!, entity);
    ModelGuard.value = entity;

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
    // Formulaire pour le modèle
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(children: [
          // En-tête de la page
          PageHeader(
            title: AppLocalizations.of(context)!.dashboard_model_title,
            onSave: saveModel,
          ),
          // Formulaire pour le nom du modèle
          ModelNameForm(
            name: entity.name,
            onChange: (newName) {
              entity.name = newName;
              setState(() {});
            },
          ),
          // Éditeur pour les entrées de revenus
          BudgetLinesEditor(
            entries: entity.copyWith().incomes,
            title: AppLocalizations.of(context)!.budget_incomes,
            onChange: (entries) {
              var currentEntries = entity.copyWith().incomes;
              entity.incomes = entries;
              EventService.emitter
                  .emit('refresh/balance', this, (entity.total, 0));
              if (currentEntries.length != entries.length) {
                setState(() {});
              }
            },
          ),
          // Éditeur pour les entrées de dépenses
          BudgetLinesEditor(
            entries: entity.copyWith().expenses,
            title: AppLocalizations.of(context)!.budget_expenses,
            onChange: (entries) {
              var currentEntries = entity.copyWith().expenses;
              entity.expenses = entries;
              EventService.emitter
                  .emit('refresh/balance', this, (entity.total, 0));
              if (currentEntries.length != entries.length) {
                setState(() {});
              }
            },
          ),
          // Éditeur pour les entrées de projets
          ProjectLinesEditor(
            entries: entity.copyWith().projectEntries,
            title: AppLocalizations.of(context)!.project_entries_title,
            onChange: (entries) {
              var currentEntries = entity.copyWith().projectEntries;
              entity.projectEntries = entries;
              EventService.emitter
                  .emit('refresh/balance', this, (entity.total, 0));
              if (currentEntries.length != entries.length) {
                setState(() {});
              }
            },
          ),
          // Balance du modèle
          BalanceWidget(
            balance: entity.total,
            receivedBalance: 0,
            width: MediaQuery.of(context).size.width,
            isCurrent: false,
          ),
          const SizedBox(
            height: 100,
          ),
        ]),
      ),
    );
  }
}
