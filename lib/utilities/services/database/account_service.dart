import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

/// Service pour les comptes
class AccountService {
  /// Id de l'utilisateur courant
  String get userId {
    return AuthService.getCurrentUser()!.uid;
  }

  /// Référence à la table
  DatabaseReference get _ref => FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(userId)
      .child('account');

  /// Met à jour le solde
  Future<double> setBalance(double newBalance) async {
    await _ref.set(newBalance);
    return newBalance;
  }

  /// Retourne le solde
  Future<double> getBalance() async {
    var result = await _ref.once();
    return double.tryParse(result.snapshot.value.toString()) ?? 0;
  }
}
