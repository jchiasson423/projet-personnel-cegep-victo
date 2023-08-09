// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:budget_maker_app/utilities/entities/base_entity.dart';
import 'package:budget_maker_app/utilities/models/project_entry_model.dart';
import 'package:flutter/foundation.dart';

import 'package:budget_maker_app/utilities/models/money_entry_model.dart';

/// Entité pour les budgets
class Budget extends BaseEntity {
  /// Id dans la base de données
  String? id;

  /// Date de début du budget
  DateTime startDate;

  /// Date de fin du budget
  DateTime endDate;

  /// Id de l'utilisateur
  String userId;

  /// Liste des entrées d'argent
  List<MoneyEntry> incomes;

  /// Liste des dépenses
  List<MoneyEntry> expenses;

  /// Liste des entrées de projet
  List<ProjectEntry> projectEntries;

  /// Vérifie si le budget est en cours
  bool get isCurrent {
    var now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  /// Vérifie si le budget est passé
  bool get isPassed {
    var now = DateTime.now();
    return now.isAfter(endDate);
  }

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

  /// Retourne le total (balance du budget)
  double get total {
    return totalIncome - totalExpense - totalProject;
  }

  /// Retourne le total des entrées d'argent reçues
  double get totalReceivedIncome {
    return incomes.fold<double>(
      0,
      (previousValue, element) => previousValue + (element.receivedAmount ?? 0),
    );
  }

  /// Retourne le total des dépenses reçues
  double get totalReceivedExpense {
    return expenses.fold<double>(
      0,
      (previousValue, element) => previousValue + (element.receivedAmount ?? 0),
    );
  }

  /// Retourne le total des entrées de projet reçues
  double get totalReceivedProject {
    return projectEntries.fold<double>(
      0,
      (previousValue, element) => previousValue + (element.realAmount ?? 0),
    );
  }

  /// Retourne le total reçu (balance du budget)
  double get totalReceived {
    return totalReceivedIncome - totalReceivedExpense - totalReceivedProject;
  }

  /// Retourne le montant du compte selon le [accountAmount] et les différentes
  /// entrées
  double realAccountAmout(double accountAmount) {
    // Calcul des revenus restants
    double remainingIncome = totalIncome - totalReceivedIncome;
    if (remainingIncome < 0) {
      remainingIncome = 0;
    }

    // Calcul des dépenses restantes
    double remainingExpense = totalExpense - totalReceivedExpense;
    if (remainingExpense < 0) {
      remainingExpense = 0;
    }

    // Calcul des projets restants
    double remainingProject = totalProject - totalReceivedProject;
    if (remainingProject < 0) {
      remainingProject = 0;
    }

    // Calcul du montant réel du compte
    double realAccountAmount =
        accountAmount + remainingIncome - remainingExpense - remainingProject;

    return realAccountAmount;
  }

  /// Constructeur du budget
  Budget({
    this.id,
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.incomes,
    required this.expenses,
    this.projectEntries = const [],
  });

  /// Crée une copie du budget
  Budget copyWith({
    String? id,
    DateTime? startDate,
    DateTime? endDate,
    String? userId,
    List<MoneyEntry>? incomes,
    List<MoneyEntry>? expenses,
    List<ProjectEntry>? projectEntries,
  }) {
    return Budget(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      userId: userId ?? this.userId,
      incomes: incomes ?? this.incomes,
      expenses: expenses ?? this.expenses,
      projectEntries: projectEntries ?? this.projectEntries,
    );
  }

  /// Convertis le budget en Map
  @override
  Map<String, dynamic> toMap({bool withId = true}) {
    return <String, dynamic>{
      if (withId) 'id': id,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'userId': userId,
      'incomes': incomes.map((x) => x.toMap()).toList(),
      'expenses': expenses.map((x) => x.toMap()).toList(),
      'projectEntries': projectEntries.map((x) => x.toMap()).toList(),
    };
  }

  /// Crée un budget à partir d'une Map
  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      startDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['startDate'].toString())),
      endDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['endDate'].toString())),
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

  /// Convertis le budget en String Json
  String toJson() => json.encode(toMap());

  /// Crée un budget à partir d'un String Json
  factory Budget.fromJson(String source) =>
      Budget.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Convertis le budget en String
  @override
  String toString() {
    return 'Budget(id: $id, startDate: $startDate, endDate: $endDate, userId: $userId, incomes: $incomes, expenses: $expenses, projectEntries: $projectEntries)';
  }

  /// Vérifie si deux budgets sont égaux
  @override
  bool operator ==(covariant Budget other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.startDate.millisecondsSinceEpoch ==
            startDate.millisecondsSinceEpoch &&
        other.endDate.millisecondsSinceEpoch ==
            endDate.millisecondsSinceEpoch &&
        other.userId == userId &&
        listEquals(other.incomes, incomes) &&
        listEquals(other.expenses, expenses) &&
        listEquals(other.projectEntries, projectEntries);
  }

  /// Retourne le hashcode du budget
  @override
  int get hashCode {
    return id.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        userId.hashCode ^
        incomes.hashCode ^
        expenses.hashCode ^
        projectEntries.hashCode;
  }

  /// Compare deux budgets
  @override
  int compareTo(BaseEntity other) {
    if (other is! Budget) return -1;
    return startDate.compareTo(other.startDate);
  }
}
