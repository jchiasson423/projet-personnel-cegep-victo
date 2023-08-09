// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:budget_maker_app/utilities/entities/project_entity.dart';

/// Modèle pour les entrées de projet
class ProjectEntry {
  /// Id du projet
  String projectId;

  /// Montant de l'entrée
  double amount;

  /// Montant réel
  double? realAmount;

  // Pas dans la base de données. Utilisé pour l'affichage plus tard.
  /// Date de l'entrée
  DateTime? entryDate;

  /// Projet
  Project? project;

  /// Constructeur
  ProjectEntry({
    required this.projectId,
    required this.amount,
    this.realAmount,
    this.entryDate,
    this.project,
  });

  /// Copie de l'entrée
  ProjectEntry copyWith({
    String? projectId,
    double? amount,
    double? realAmount,
    DateTime? entryDate,
    Project? project,
  }) {
    return ProjectEntry(
      projectId: projectId ?? this.projectId,
      amount: amount ?? this.amount,
      realAmount: realAmount ?? this.realAmount,
      entryDate: entryDate ?? this.entryDate,
      project: project ?? this.project,
    );
  }

  /// Convertit l'entrée en map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'projectId': projectId,
      'amount': amount,
      'realAmount': realAmount,
    };
  }

  /// Convertit la map en entrée
  factory ProjectEntry.fromMap(Map<String, dynamic> map) {
    return ProjectEntry(
      projectId: map['projectId'] as String,
      amount: double.parse(map['amount'].toString()),
      realAmount: map['realAmount'] != null
          ? double.parse(map['realAmount'].toString())
          : null,
    );
  }

  /// Convertit l'entrée en json
  String toJson() => json.encode(toMap());

  /// Convertit le json en entrée
  factory ProjectEntry.fromJson(String source) =>
      ProjectEntry.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Convertit l'entrée en String
  @override
  String toString() =>
      'ProjectEntry(projectId: $projectId, amount: $amount, realAmount: $realAmount, entryDate: $entryDate, project: $project)';

  /// Vérifie si deux entrées sont égales
  @override
  bool operator ==(covariant ProjectEntry other) {
    if (identical(this, other)) return true;

    return other.projectId == projectId &&
        other.amount == amount &&
        other.realAmount == realAmount &&
        other.entryDate == entryDate &&
        other.project == project;
  }

  /// Hashcode de l'entrée
  @override
  int get hashCode =>
      projectId.hashCode ^
      amount.hashCode ^
      realAmount.hashCode ^
      entryDate.hashCode ^
      project.hashCode;
}
