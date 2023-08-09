import 'package:budget_maker_app/utilities/services/events_service.dart';
import 'package:budget_maker_app/widgets/budgets/budget_date_form.dart';
import 'package:budget_maker_app/widgets/page_header_widget.dart';
import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/utilities/guards/entity_guards/budget_guard.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/budgets/balance_widget.dart';
import 'package:budget_maker_app/widgets/budgets/budget_lines_editor.dart';
import 'package:budget_maker_app/widgets/projects/project_lines_editor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

/// Page pour un budget
class BudgetPage extends StatefulWidget {
  const BudgetPage({
    super.key,
  });

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  /// Clé du formulaire
  var formKey = GlobalKey<FormState>(debugLabel: 'budget_form');

  /// Budget
  late Budget entity;

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    entity = BudgetGuard.value;
  }

  /// Sauvegarde le budget
  saveBudget() async {
    // Valide le formulaire
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Sauvegarde le budget
    entity = await Services.budgets.update(entity.id!, entity);
    BudgetGuard.value = entity;

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
    // Formulaire du budget
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // En-tête
            PageHeader(
              title: AppLocalizations.of(context)!.dashboard_budget_title,
              onSave: entity.isPassed ? null : saveBudget,
            ),
            // Date de début
            BudgetDateForm(
              name: AppLocalizations.of(context)!.general_start_date,
              noDataMessage:
                  AppLocalizations.of(context)!.general_start_date_empty,
              date: entity.startDate,
              endDate: entity.endDate,
              onChange: (newDate) {
                entity.startDate = newDate;
                setState(() {});
              },
            ),
            // Date de fin
            BudgetDateForm(
              name: AppLocalizations.of(context)!.general_end_date,
              noDataMessage:
                  AppLocalizations.of(context)!.general_end_date_empty,
              date: entity.endDate,
              startDate: entity.startDate,
              onChange: (newDate) {
                entity.endDate = newDate;
                setState(() {});
              },
            ),
            // Revenus
            BudgetLinesEditor(
              entries: entity.incomes,
              isCurrent: entity.isCurrent,
              canAdd: !entity.isPassed,
              title: AppLocalizations.of(context)!.budget_incomes,
              onChange: (entries) {
                var currentEntries = entity.copyWith().incomes;
                entity.incomes = entries;
                EventService.emitter.emit('refresh/balance', this,
                    (entity.total, entity.totalReceived));
                if (currentEntries.length != entries.length) {
                  setState(() {});
                }
              },
            ),
            // Dépenses
            BudgetLinesEditor(
              entries: entity.expenses,
              isCurrent: entity.isCurrent,
              canAdd: !entity.isPassed,
              title: AppLocalizations.of(context)!.budget_expenses,
              onChange: (entries) {
                var currentEntries = entity.copyWith().expenses;
                entity.expenses = entries;
                EventService.emitter.emit('refresh/balance', this,
                    (entity.total, entity.totalReceived));
                if (currentEntries.length != entries.length) {
                  setState(() {});
                }
              },
            ),
            // Projets
            ProjectLinesEditor(
              entries: entity.projectEntries,
              isCurrent: entity.isCurrent,
              title: AppLocalizations.of(context)!.projects_title,
              onChange: (entries) {
                var currentEntries = entity.copyWith().projectEntries;
                entity.projectEntries = entries;
                EventService.emitter.emit('refresh/balance', this,
                    (entity.total, entity.totalReceived));
                if (currentEntries.length != entries.length) {
                  setState(() {});
                }
              },
            ),
            // Balance
            BalanceWidget(
              balance: entity.total,
              receivedBalance: entity.totalReceived,
              width: MediaQuery.of(context).size.width,
              isCurrent: entity.isCurrent,
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
