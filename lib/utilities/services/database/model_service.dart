import 'package:budget_maker_app/utilities/entities/model_entity.dart';
import 'package:budget_maker_app/utilities/services/database/base_entity_service.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';

/// Service pour les modèles de budget
class ModelService extends BaseEntityService<Model> {
  /// Constructeur
  ModelService({super.table = 'models', required super.fromMap});

  /// Retourne tous les modèles
  @override
  Future<List<Model>> getAll() async {
    // Récupère les modèles
    var models = await super.getAll();

    // Récupère les entrées de projet
    models = await populateProjectEntries(models);

    return models;
  }

  /// Retourne le modèle avec l'id spécifié
  @override
  Future<Model?> getById(String id) async {
    // Récupère le modèle
    var model = await super.getById(id);

    // Si le modèle n'existe pas, retourne null
    if (model == null) {
      return null;
    }

    // Récupère les entrées de projet
    model = (await populateProjectEntries([model])).first;

    return model;
  }

  /// Récupère les entrées de projet
  Future<List<Model>> populateProjectEntries(List<Model> models) async {
    // Récupère tous les projets
    var projects = await Services.projects.getAll();

    // Si pas de projets, retourne les modèles sans entrées de projet
    if (projects.isEmpty) {
      return models;
    }

    // Récupère les entrées de projet
    for (var i = 0; i < models.length; i++) {
      var entries = models[i].projectEntries;
      for (var j = 0; j < entries.length; j++) {
        // Récupère le projet de l'entrée
        entries[j].project = projects
            .firstWhere((project) => project.id == entries[j].projectId);
      }
      models[i].projectEntries = entries;
    }

    return models;
  }
}
