// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:budget_maker_app/utilities/entities/base_entity.dart';
import 'package:budget_maker_app/utilities/entities/budget_entity.dart';
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:flutter/foundation.dart';

import 'package:budget_maker_app/utilities/models/money_entry_model.dart';

/// Entité pour les modèles de budget
class Model extends BaseEntity {
  /// Id dans la base de données
  String? id;

  /// Nom du modèle
  String name;

  /// Id de l'utilisateur
  String? userId;

  /// Liste des entrées d'argent
  List<MoneyEntry> incomes;

  /// Liste des dépenses
  List<MoneyEntry> expenses;

  /// Liste des entrées de projet
  List<ProjectEntry> projectEntries;

  /// Retourne le total des entrées d'argent
  double get totalIncome {
    return incomes.fold<double>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
  }

  /// Retourne le total des dépenses
  double get totalExpense {
    return expenses.fold<double>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
  }

  /// Retourne le total des entrées de projet
  double get totalProject {
    return projectEntries.fold<double>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
  }

  /// Retourne le total du modèle (balance)
  double get total {
    return totalIncome - totalExpense - totalProject;
  }

  /// Crée un budget à partir du modèle
  Budget createBudget(DateTime startDate, DateTime endDate) {
    // Met les entrées d'argent réelles à 0
    var currentIncomes = [];
    for (var income in incomes) {
      income.receivedAmount = null;
      currentIncomes.add(income);
    }

    // Met les dépenses réelles à 0
    var currentExpenses = [];
    for (var expense in expenses) {
      expense.receivedAmount = null;
      currentExpenses.add(expense);
    }

    // Met les entrées de projet réelles à 0
    var currentProjectEntries = [];
    for (var projectEntry in projectEntries) {
      projectEntry.realAmount = null;
      currentProjectEntries.add(projectEntry);
    }

    // Va chercher l'utilisateur courant
    var user = AuthService.getCurrentUser()!;

    // Crée le budget
    return Budget(
      id: id,
      userId: userId ?? user.uid,
      startDate: startDate,
      endDate: endDate,
      incomes: incomes,
      expenses: expenses,
      projectEntries: projectEntries,
    );
  }

  /// Constructeur du modèle
  Model({
    this.id,
    required this.name,
    this.userId,
    this.incomes = const [],
    this.expenses = const [],
    this.projectEntries = const [],
  });

  /// Copie le modèle
  Model copyWith({
    String? id,
    String? name,
    String? userId,
    List<MoneyEntry>? incomes,
    List<MoneyEntry>? expenses,
    List<ProjectEntry>? projectEntries,
  }) {
    return Model(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      incomes: incomes ?? this.incomes,
      expenses: expenses ?? this.expenses,
      projectEntries: projectEntries ?? this.projectEntries,
    );
  }

  /// Convertis le modèle en Map
  @override
  Map<String, dynamic> toMap({bool withId = true}) {
    return <String, dynamic>{
      if (withId) 'id': id,
      'name': name,
      'userId': userId,
      'incomes': incomes.map((x) => x.toMap()).toList(),
      'expenses': expenses.map((x) => x.toMap()).toList(),
      'projectEntries': projectEntries.map((x) => x.toMap()).toList(),
    };
  }

  /// Crée un modèle à partir d'une Map
  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      id: map['id'],
      name: map['name'],
      userId: map['userId'],
      incomes: map['incomes'] != null
          ? List<MoneyEntry>.from(
              (map['incomes'] as List).map<MoneyEntry>(
                (x) => MoneyEntry.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      expenses: map['expenses'] != null
          ? List<MoneyEntry>.from(
              (map['expenses'] as List).map<MoneyEntry>(
                (x) => MoneyEntry.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      projectEntries: map['projectEntries'] != null
          ? List<ProjectEntry>.from(
              (map['projectEntries'] as List).map<ProjectEntry>(
                (x) => ProjectEntry.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  /// Convertis le modèle en String JSON
  String toJson() => json.encode(toMap());

  /// Crée un modèle à partir d'un String JSON
  factory Model.fromJson(String source) =>
      Model.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Retourne une représentation du modèle en String
  @override
  String toString() {
    return 'BudgetModel(id: $id, name: $name, userId: $userId, incomes: $incomes, expenses: $expenses, projectEntries: $projectEntries)';
  }

  /// Vérifie si deux modèles sont égaux
  @override
  bool operator ==(covariant Model other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.userId == userId &&
        listEquals(other.incomes, incomes) &&
        listEquals(other.expenses, expenses) &&
        listEquals(other.projectEntries, projectEntries);
  }

  /// Retourne le hashcode du modèle
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        incomes.hashCode ^
        expenses.hashCode ^
        projectEntries.hashCode;
  }

  /// Compare deux modèles
  @override
  int compareTo(BaseEntity other) {
    if (other is Model) {
      return name.compareTo(other.name);
    }
    return -1;
  }
}
