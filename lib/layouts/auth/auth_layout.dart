import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/config/delegates/auth_delegate.dart';
import 'package:flutter/material.dart';

/// Interface pour les pages de connexion
class AuthLayout extends StatefulWidget {
  const AuthLayout({
    super.key,
  });

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  /// Delegate pour la navigation
  final _delegate = authDelegate();

  /// Clé pour le Beamer
  final _beamerKey = const ValueKey('auth-beamer');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _beamerKey,
      extendBodyBehindAppBar: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // Beamer pour la navigation
        child: Beamer(
          routerDelegate: _delegate,
          key: _beamerKey,
        ),
      ),
    );
  }
}
