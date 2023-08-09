import 'package:collection/collection.dart';

import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/utilities/entities/project_entity.dart';
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:budget_maker_app/utilities/services/database/base_entity_service.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';

/// Service pour les projets
class ProjectService extends BaseEntityService<Project> {
  /// Constructeur
  ProjectService({super.table = 'projects', required super.fromMap});

  /// Retourne tous les projets
  @override
  Future<List<Project>> getAll() async {
    // Récupère les projets
    var projects = await super.getAll();

    // Récupère les entrées de projet
    projects = await populateProjectEntries(projects);

    return projects;
  }

  /// Retourne le projet avec l'id spécifié
  @override
  Future<Project?> getById(String id) async {
    // Récupère le projet
    var project = await super.getById(id);

    // Si le projet n'existe pas, retourne null
    if (project == null) {
      return null;
    }

    // Récupère les entrées de projet
    project = (await populateProjectEntries([project])).first;

    return project;
  }

  /// Supprime le projet avec l'id spécifié
  @override
  Future<void> delete(String id) async {
    // Récupère le projet
    var project = await getById(id);

    // Si le projet n'existe pas, retourne
    if (project == null) {
      return;
    }

    // Supprime les entrées de projet
    await deleteProjectEntries(id);

    // Supprime le projet
    return super.delete(id);
  }

  /// Récupère les entrées de projet
  Future<List<Project>> populateProjectEntries(List<Project> projects) async {
    // Récupère tous les budgets
    List<Budget> budgets = await Services.budgets.getAll();

    List<ProjectEntry> allEntries = [];

    // Récupère les entrées de projet
    for (var budget in budgets) {
      var currentEntry = budget.projectEntries.firstWhereOrNull((element) =>
          projects.any((project) => project.id == element.projectId));

      if (currentEntry == null) {
        continue;
      }
      currentEntry.entryDate = budget.endDate;

      allEntries.add(currentEntry);
    }

    // Associe les entrées de projet aux projets
    for (var i = 0; i < projects.length; i++) {
      var id = projects[i].id;

      projects[i].entries =
          allEntries.where((element) => element.projectId == id).toList();
      for (var j = 0; j < projects[i].entries.length; j++) {
        projects[i].entries[j].project = projects[i];
      }
    }

    return projects;
  }

  /// Supprime les entrées de projet avec l'id spécifié
  Future<void> deleteProjectEntries(String id) async {
    // Je fais une liste de future ici pour sauver du temps d'exécution
    List<Future> futures = [];

    // Récupère tous les budgets
    var budgets = await Services.budgets.getAll();

    // Supprime les entrées de projet des budgets
    for (var budget in budgets) {
      if (budget.projectEntries.any((element) => element.projectId == id)) {
        budget.projectEntries.removeWhere((element) => element.projectId == id);
        futures.add(Services.budgets.update(budget.id!, budget));
      }
    }

    // Récupère tous les modèles
    var models = await Services.models.getAll();

    // Supprime les entrées de projet des modèles
    for (var model in models) {
      if (model.projectEntries.any((element) => element.projectId == id)) {
        model.projectEntries.removeWhere((element) => element.projectId == id);
        futures.add(Services.models.update(model.id!, model));
      }
    }

    // Exécute toutes les fonctions asynchrones en même temps
    await Future.wait(futures);
  }
}
