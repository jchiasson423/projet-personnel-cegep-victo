// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// Modèle pour les entrées d'argent
class MoneyEntry {
  /// Nom de l'entrée
  String name;

  /// Montant de l'entrée
  double amount;

  /// Montant reçu
  double? receivedAmount;

  /// Montant restant
  double get difference => amount - (receivedAmount ?? 0);

  /// Constructeur
  MoneyEntry({
    required this.name,
    required this.amount,
    this.receivedAmount,
  });

  /// Copie de l'entrée
  MoneyEntry copyWith({
    String? name,
    double? amount,
    double? receivedAmount,
  }) {
    return MoneyEntry(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      receivedAmount: receivedAmount ?? this.receivedAmount,
    );
  }

  /// Convertit l'entrée en map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'amount': amount,
      'receivedAmount': receivedAmount,
    };
  }

  /// Convertit la map en entrée
  factory MoneyEntry.fromMap(Map<String, dynamic> map) {
    return MoneyEntry(
      name: map['name'] as String,
      amount: double.parse(map['amount'].toString()),
      receivedAmount: double.tryParse(map['receivedAmount'].toString()),
    );
  }

  /// Convertit l'entrée en json
  String toJson() => json.encode(toMap());

  /// Convertit le json en entrée
  factory MoneyEntry.fromJson(String source) =>
      MoneyEntry.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Convertit l'entrée en string
  @override
  String toString() {
    return 'MoneyEntry(name: $name, amount: $amount, receivedAmount: $receivedAmount)';
  }

  /// Compare deux entrées
  @override
  bool operator ==(covariant MoneyEntry other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.amount == amount &&
        other.receivedAmount == receivedAmount;
  }

  /// Hashcode de l'entrée
  @override
  int get hashCode {
    return name.hashCode ^ amount.hashCode ^ receivedAmount.hashCode;
  }
}
