import 'package:budget_maker_app/config/delegates/main_delegate.dart';
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:flutter/material.dart';

/// Garde pour l'authentification
class AuthGuard extends StatelessWidget {
  /// Enfant du garde à afficher
  final Widget child;

  /// Url de la page de connexion
  final String loginUrl;

  /// Constructeur
  const AuthGuard({
    super.key,
    required this.child,
    this.loginUrl = '/auth/login',
  });

  @override
  Widget build(BuildContext context) {
    // Vérifie si l'utilisateur est connecté
    var user = AuthService.getCurrentUser();
    if (user == null) {
      // Si non, redirige vers la page de connexion
      mainDelegate.beamToNamed(loginUrl);
      return Container();
    }

    // Retourne l'enfant
    return child;
  }
}
