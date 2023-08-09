import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/utilities/services/database/base_entity_service.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';

/// Service pour les budgets
class BudgetService extends BaseEntityService<Budget> {
  /// Constructeur
  BudgetService({super.table = 'budgets', required super.fromMap});

  /// Retourne tous les budgets
  @override
  Future<List<Budget>> getAll() async {
    // Récupère les budgets
    var budgets = await super.getAll();

    return budgets;
  }

  /// Retourne le budget avec l'id spécifié
  @override
  Future<Budget?> getById(String id) async {
    // Récupère le budget
    var budget = await super.getById(id);

    // Si le budget n'existe pas, retourne null
    if (budget == null) {
      return null;
    }

    // Récupère les entrées de projet
    budget = (await populateProjectEntries([budget])).first;

    return budget;
  }

  /// Retourne les budgets avant la date de maintenant
  Future<List<Budget>> getBeforeEndDate() async {
    // Récupère tous les budgets
    List<Budget> allBudgets = await getAll();
    var currentTime = DateTime.now();

    // Filtre les budgets avant la date de maintenant
    List<Budget> budgetsBeforeEndDate = allBudgets
        .where((budget) =>
            budget.endDate.millisecondsSinceEpoch <
            currentTime.millisecondsSinceEpoch)
        .toList();

    // Récupère les entrées de projet
    budgetsBeforeEndDate = await populateProjectEntries(budgetsBeforeEndDate);

    return budgetsBeforeEndDate;
  }

  /// Retourne les budgets après la date de maintenant
  Future<List<Budget>> getAfterEndDate() async {
    // Récupère tous les budgets
    List<Budget> allBudgets = await getAll();
    var currentTime = DateTime.now();

    // Filtre les budgets après la date de maintenant
    List<Budget> budgetsAfterEndDate = allBudgets
        .where((budget) =>
            budget.endDate.millisecondsSinceEpoch >=
            currentTime.millisecondsSinceEpoch)
        .toList();

    // Récupère les entrées de projet
    budgetsAfterEndDate = await populateProjectEntries(budgetsAfterEndDate);

    return budgetsAfterEndDate;
  }

  /// Récupère les entrées de projet
  Future<List<Budget>> populateProjectEntries(List<Budget> budgets) async {
    // Récupère tous les projets
    var projects = await Services.projects.getAll();

    // Si pas de projets, retourne les budgets sans entrées de projet
    if (projects.isEmpty) {
      return budgets;
    }

    // Récupère les entrées de projet
    for (var i = 0; i < budgets.length; i++) {
      var entries = budgets[i].projectEntries;

      for (var j = 0; j < entries.length; j++) {
        // Récupère les données de l'entrée de projet
        entries[j].project = projects
            .firstWhere((project) => project.id == entries[j].projectId);
        entries[j].entryDate = budgets[i].endDate;
      }

      budgets[i].projectEntries = entries;
    }

    return budgets;
  }
}
