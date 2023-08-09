import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/layouts/auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Responsable de la navigation pour la connexion
BeamerDelegate authDelegate() {
  return BeamerDelegate(
    initialPath: '/auth/login',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        //Route de connexion
        '/auth/login': (context, state, data) {
          return BeamPage(
            key: const ValueKey('auth-login-page'),
            type: BeamPageType.fadeTransition,
            title: AppLocalizations.of(context)!.auth_login_title,
            child: const LoginPage(),
          );
        },
      },
    ),
  );
}
