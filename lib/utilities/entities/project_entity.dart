// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:budget_maker_app/utilities/entities/base_entity.dart';
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:flutter/foundation.dart';

/// Entité pour les projets
class Project extends BaseEntity {
  /// Id dans la base de données
  String? id;

  /// Nom du projet
  String name;

  /// Objectif du projet
  double objective;

  /// Date de l'objectif
  DateTime objectiveDate;

  /// Montant actuel
  double currentAmount;

  // Pas dans la base de données. Populé plus tard à partir des entrées dans les budgets
  /// Liste des entrées de projet
  List<ProjectEntry> entries;

  /// Retourne le montant à la date de l'objectif
  double get amountAtDate {
    // Aucun entrée, montant à 0
    if (entries.isEmpty) {
      return 0;
    }

    // Filtre les entrées avant la date de l'objectif
    entries = entries
        .where((element) => element.entryDate!.isBefore(objectiveDate))
        .toList();

    // Aucune entrée avant la date de l'objectif, montant à 0
    if (entries.isEmpty) {
      return 0;
    }

    // Calcul du montant
    var entriesAmount = entries.fold(currentAmount,
        (previousValue, element) => previousValue + (element.amount));

    return entriesAmount;
  }

  /// Vérifie si l'objectif est atteint à la date de l'objectif
  bool get accomplishedAtDate {
    var amount = amountAtDate;
    return amount >= objective;
  }

  /// Vérifie si l'objectif est atteint
  bool get accomplished {
    return currentAmount >= objective;
  }

  /// Retourne la date d'accomplissement
  DateTime? get accomplishmentDate {
    // Aucun entrée, pas de date d'accomplissement
    if (entries.isEmpty) {
      return null;
    }

    // Filtre les entrées avant la date de l'objectif
    entries = entries
        .where((element) => element.entryDate!.isBefore(objectiveDate))
        .toList();

    // Aucune entrée avant la date de l'objectif, pas de date d'accomplissement
    if (entries.isEmpty) {
      return null;
    }

    // Trie les entrées par date
    entries.sort((a, b) => a.entryDate!.compareTo(b.entryDate!));

    // Si le montant actuel est plus grand ou égal à l'objectif,
    // la date d'accomplissement est la date de la première entrée
    if (currentAmount >= objective) {
      return entries.first.entryDate;
    }

    // Sinon, on calcule la date d'accomplissement
    DateTime? date;
    var amount = currentAmount;

    for (var entry in entries) {
      amount += entry.amount;
      if (amount >= objective) {
        date = entry.entryDate;
        break;
      }
    }

    return date;
  }

  /// Constructeur du projet
  Project({
    this.id,
    required this.name,
    required this.objective,
    required this.objectiveDate,
    this.currentAmount = 0,
    this.entries = const [],
  });

  /// Retourne une copie du projet avec les modifications
  Project copyWith({
    String? id,
    String? name,
    double? objective,
    DateTime? objectiveDate,
    double? currentAmount,
    List<ProjectEntry>? entries,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      objective: objective ?? this.objective,
      objectiveDate: objectiveDate ?? this.objectiveDate,
      currentAmount: currentAmount ?? this.currentAmount,
      entries: entries ?? this.entries,
    );
  }

  /// Convertis le projet en Map
  @override
  Map<String, dynamic> toMap({bool withId = true}) {
    return <String, dynamic>{
      if (withId) 'id': id,
      'name': name,
      'objective': objective,
      'objectiveDate': objectiveDate.millisecondsSinceEpoch,
      'currentAmount': currentAmount,
    };
  }

  /// Convertis la Map en projet
  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      objective: double.parse(map['objective'].toString()),
      objectiveDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['objectiveDate'].toString())),
      currentAmount: double.parse(map['currentAmount'].toString()),
    );
  }

  /// Convertis le projet en JSON
  String toJson() => json.encode(toMap());

  /// Convertis le JSON en projet
  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Retourne une copie du projet
  @override
  String toString() =>
      'Project(id: $id, name: $name, objective: $objective, objectiveDate: $objectiveDate, currentAmount: $currentAmount, entries: $entries)';

  /// Vérifie si deux projets sont égaux
  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.objective == objective &&
        other.objectiveDate.millisecondsSinceEpoch ==
            objectiveDate.millisecondsSinceEpoch &&
        other.currentAmount == currentAmount &&
        listEquals(other.entries, entries);
  }

  /// Retourne le hashcode du projet
  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      objective.hashCode ^
      objectiveDate.hashCode ^
      currentAmount.hashCode ^
      entries.hashCode;

  /// Compare deux projets
  @override
  int compareTo(BaseEntity other) {
    if (other is Project) {
      return objectiveDate.compareTo(other.objectiveDate);
    }
    return -1;
  }
}
